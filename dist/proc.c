#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"
#include "uproc.h"

#ifdef CS333_P4
#define statecount NELEM(states)
#elif defined(CS333_P3)
#define statecount NELEM(states)
#endif

static char *states[] = {
[UNUSED]    "unused",
[EMBRYO]    "embryo",
[SLEEPING]  "sleep ",
[RUNNABLE]  "runble",
[RUNNING]   "run   ",
[ZOMBIE]    "zombie"
};


#ifdef CS333_P4
struct ptrs{
    struct proc * head;
    struct proc * tail;
};
#elif defined(CS333_P3)
struct ptrs{
    struct proc * head;
    struct proc * tail;
};
#endif

static struct {
  struct spinlock lock;
  struct proc proc[NPROC];
#ifdef CS333_P4
  struct ptrs list[statecount];
  struct ptrs ready[MAXPRIO+1];
  uint PromoteAtTime;
#elif defined(CS333_P3)
  struct ptrs list[statecount];
#endif
} ptable;

static struct proc *initproc;

#ifdef CS333_P4
static void initProcessLists(void);
static void initFreeList(void);
static void assertState(struct proc*,enum procstate);
static void stateListAdd(struct ptrs*,struct proc*);
static int stateListRemove(struct ptrs*,struct proc*p);
static int promoteQueue(struct ptrs*);
static int promoteProcess(struct ptrs*);
static int findProc(struct proc*,int,int);
int setpriority(int,int);
int getpriority(int);
void control_f();
void control_r();
void control_s();
void control_z();
#elif defined(CS333_P3)
static void initProcessLists(void);
static void initFreeList(void);
static void assertState(struct proc*,enum procstate);
static void stateListAdd(struct ptrs*,struct proc*);
static int stateListRemove(struct ptrs*,struct proc*p);
void control_f();
void control_r();
void control_s();
void control_z();
#endif

uint nextpid = 1;
extern void forkret(void);
extern void trapret(void);
static void wakeup1(void* chan);

void
pinit(void)
{
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
}

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
  int apicid, i;

  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");

  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid) {
      return &cpus[i];
    }
  }
  panic("unknown apicid\n");
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
  c = mycpu();
  p = c->proc;
  popcli();
  return p;
}

// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
  int found = 0;
#ifdef CS333_P3
  p = ptable.list[UNUSED].head;
  if(p)
      found = 1;
  else if(!found){
      release(&ptable.lock);
      return 0;
  }
  int rc = stateListRemove(&ptable.list[UNUSED],p);
  if(rc < 0)
      panic("\n[UNUSED->EMBRYO]:oh no!! I'm panicking!");
  assertState(p,UNUSED);
  p->state = EMBRYO;
  stateListAdd(&ptable.list[EMBRYO],p);
#else
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED) {
      found = 1;
      break;
    }
  if (!found) {
    release(&ptable.lock);
    return 0;
  }
  p->state = EMBRYO;
#endif
  p->pid = nextpid++;
  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
#ifdef CS333_P3
      acquire(&ptable.lock);
      int rc = stateListRemove(&ptable.list[EMBRYO],p);
      if(rc < 0)
          panic("[EMBRYO->UNUSED]:oh no!! I'm panicking!");
      assertState(p,EMBRYO);
      p->state = UNUSED;
      stateListAdd(&ptable.list[UNUSED],p);
      release(&ptable.lock);
#else
      p->state = UNUSED;
#endif
      return 0;

  }
  sp = p->kstack + KSTACKSIZE;

#ifdef CS333_P2
  p->cpu_ticks_total = 0; // ini both cpu ticks to 0 if flag is turned on
  p->cpu_ticks_in = 0;
#endif
  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
#ifdef CS333_P1
  p->start_ticks = ticks;
#endif
  return p;
}

// Set up first user process.
void
userinit(void)
{
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

// Initialize the lists before calling allocproc()
#ifdef CS333_P4
  acquire(&ptable.lock);
  initProcessLists();
  initFreeList(); 
  ptable.PromoteAtTime = ticks + TICKS_TO_PROMOTE;
  release(&ptable.lock);
#elif defined(CS333_P3)
  acquire(&ptable.lock);
  initProcessLists();
  initFreeList(); 
  release(&ptable.lock);
#endif


  p = allocproc();

  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.

  acquire(&ptable.lock);
#ifdef CS333_P4
  int rc = stateListRemove(&ptable.list[EMBRYO],p);
  if(rc < 0)
      panic("\n[EMBRYO->RUNNABLE]:oh no!! I'm panicking!");
  assertState(p,EMBRYO);
  p->state = RUNNABLE;
  p->priority = MAXPRIO;
  stateListAdd(&ptable.ready[p->priority],p);
  p->parent = p; // Set the first the first proc's parent  to itself 
  p->uid = UID; // Set the uid to the# default UID = 0
  p->gid = GID; // Set the gid to the default GID = 0

#elif defined(CS333_P3)
  int rc = stateListRemove(&ptable.list[EMBRYO],p);
  if(rc < 0)
      panic("\n[EMBRYO->RUNNABLE]:oh no!! I'm panicking!");
  assertState(p,EMBRYO);
  p->state = RUNNABLE;
  stateListAdd(&ptable.list[RUNNABLE],p);
  p->parent = p; // Set the first the first proc's parent  to itself 
  p->uid = UID; // Set the uid to the default UID = 0
  p->gid = GID; // Set the gid to the default GID = 0

#elif defined (CS333_P2)
  p->state = RUNNABLE;
  p->parent = p; // Set the first the first proc's parent  to itself 
  p->uid = UID; // Set the uid to the default UID = 0
  p->gid = GID; // Set the gid to the default GID = 0
#else
  p->state = RUNNABLE;
#endif
  release(&ptable.lock);
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
  return 0;
}

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
  int i;
  uint pid;
  struct proc *np;
  struct proc *curproc = myproc();

  //cprintf("\nTHIS IS THE NP FROM FORK 3");
  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
    np->kstack = 0;
#ifdef CS333_P4
    acquire(&ptable.lock);
    int rc = stateListRemove(&ptable.list[EMBRYO],np);
    if(rc < 0)
        panic("[EMBRYO->UNUSED]:oh no!! I'm Panicking!");
    assertState(np,EMBRYO);
    np->state = UNUSED;
    stateListAdd(&ptable.list[UNUSED],np);
    release(&ptable.lock);
#elif defined(CS333_P3)
    acquire(&ptable.lock);
    int rc = stateListRemove(&ptable.list[EMBRYO],np);
    if(rc < 0)
        panic("[EMBRYO->UNUSED]:oh no!! I'm Panicking!");
    assertState(np,EMBRYO);
    np->state = UNUSED;
    stateListAdd(&ptable.list[UNUSED],np);
    release(&ptable.lock);
#else
    np->state = UNUSED;
#endif
    return -1;
  }
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

#ifdef CS333_P2
  // COPY the UID & GID to the new proc struct
  np->uid = curproc->uid;
  np->gid = curproc->gid;
#endif

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));

  pid = np->pid;

  acquire(&ptable.lock);
#ifdef CS333_P4
int rc = stateListRemove(&ptable.list[EMBRYO],np);
  if(rc < 0)
      panic("\n[EMBRYO->RUNNABLE]:oh no!! I'm panicking!");
  assertState(np,EMBRYO);
  np->state = RUNNABLE;
  np->priority = MAXPRIO;
  stateListAdd(&ptable.ready[np->priority],np);
#elif defined(CS333_P3)
  int rc = stateListRemove(&ptable.list[EMBRYO],np);
  if(rc < 0)
      panic("\n[EMBRYO->RUNNABLE]:oh no!! I'm panicking!");
  assertState(np,EMBRYO);
  np->state = RUNNABLE;
  stateListAdd(&ptable.list[RUNNABLE],np);
#else
  np->state = RUNNABLE;
#endif
  release(&ptable.lock);

  return pid;
}

#ifdef CS333_P4
void
exit(void)
{
  struct proc *curproc = myproc();
  struct proc * embryo_p;
  struct proc * runnable_p;
  struct proc * running_p;
  struct proc * sleeping_p;
  struct proc * zombie_p;
  struct proc * current;
  int fd, rc;

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(curproc->cwd);
  end_op();
  curproc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  embryo_p = ptable.list[EMBRYO].head;
  while(embryo_p){
      if(embryo_p->parent == curproc){
          embryo_p->parent = initproc;
          if(embryo_p->state == ZOMBIE)
              wakeup1(initproc);
      }
      current = embryo_p->next;
      embryo_p = current;
  }

  for(int i=0;i<MAXPRIO+1;++i){
      runnable_p = ptable.ready[i].head;
      while(runnable_p){
          if(runnable_p->parent == curproc){
              runnable_p->parent = initproc;
              if(runnable_p->state == ZOMBIE)
                  wakeup1(initproc);
          }
          current = runnable_p->next;
          runnable_p = current;
      }
  }

  running_p = ptable.list[RUNNING].head;
  while(running_p){
      if(running_p->parent == curproc){
          running_p->parent = initproc;
          if(running_p->state == ZOMBIE)
              wakeup1(initproc);
      }
      current = running_p->next;
      running_p = current;
  }

  sleeping_p = ptable.list[SLEEPING].head;
  while(sleeping_p){
      if(sleeping_p->parent == curproc){
          sleeping_p->parent = initproc;
          if(sleeping_p->state == ZOMBIE)
              wakeup1(initproc);
      }
      current = sleeping_p->next;
      sleeping_p = current;
  }

  zombie_p = ptable.list[ZOMBIE].head;
  while(zombie_p){
      if(zombie_p->parent == curproc){
          zombie_p->parent = initproc;
          if(zombie_p->state == ZOMBIE)
              wakeup1(initproc);
      }
      current = zombie_p->next;
      zombie_p = current;
  }
    // Jump into the scheduler, never to return.
  rc = stateListRemove(&ptable.list[RUNNING],curproc);
  if(rc < 0)
      panic("[RUNNING->ZOMBIE]:oh no!! I'm panicking!");
  assertState(curproc,RUNNING);
  curproc->state = ZOMBIE;
  stateListAdd(&ptable.list[ZOMBIE],curproc);
  sched();
  panic("zombie exit");
}



#elif defined(CS333_P3)

void
exit(void)
{
  struct proc *curproc = myproc();
  struct proc * embryo_p;
  struct proc * runnable_p;
  struct proc * running_p;
  struct proc * sleeping_p;
  struct proc * zombie_p;
  struct proc * current;
  int fd, rc;

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(curproc->cwd);
  end_op();
  curproc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  embryo_p = ptable.list[EMBRYO].head;
  while(embryo_p){
      if(embryo_p->parent == curproc){
          embryo_p->parent = initproc;
          if(embryo_p->state == ZOMBIE)
              wakeup1(initproc);
      }
      current = embryo_p->next;
      embryo_p = current;
  }

  runnable_p = ptable.list[RUNNABLE].head;
  while(runnable_p){
      if(runnable_p->parent == curproc){
          runnable_p->parent = initproc;
          if(runnable_p->state == ZOMBIE)
              wakeup1(initproc);
      }
      current = runnable_p->next;
      runnable_p = current;
  }
  

  running_p = ptable.list[RUNNING].head;
  while(running_p){
      if(running_p->parent == curproc){
          running_p->parent = initproc;
          if(running_p->state == ZOMBIE)
              wakeup1(initproc);
      }
      current = running_p->next;
      running_p = current;
  }

  sleeping_p = ptable.list[SLEEPING].head;
  while(sleeping_p){
      if(sleeping_p->parent == curproc){
          sleeping_p->parent = initproc;
          if(sleeping_p->state == ZOMBIE)
              wakeup1(initproc);
      }
      current = sleeping_p->next;
      sleeping_p = current;
  }

  zombie_p = ptable.list[ZOMBIE].head;
  while(zombie_p){
      if(zombie_p->parent == curproc){
          zombie_p->parent = initproc;
          if(zombie_p->state == ZOMBIE)
              wakeup1(initproc);
      }
      current = zombie_p->next;
      zombie_p = current;
  }
    // Jump into the scheduler, never to return.
  rc = stateListRemove(&ptable.list[RUNNING],curproc);
  if(rc < 0)
      panic("[RUNNING->ZOMBIE]:oh no!! I'm panicking!");
  assertState(curproc,RUNNING);
  curproc->state = ZOMBIE;
  stateListAdd(&ptable.list[ZOMBIE],curproc);
  sched();
  panic("zombie exit");
}


#else
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(curproc->cwd);
  end_op();
  curproc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
      if(p->state == ZOMBIE)
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
  sched();
  panic("zombie exit");
}

#endif

#ifdef CS333_P4
int
wait(void)
{
  struct proc * embryo_p;
  struct proc * runnable_p;
  struct proc * running_p;
  struct proc * sleeping_p;
  struct proc * zombie_p;
  int havekids,rc;
  uint pid;
  struct proc *curproc = myproc();
  struct proc * current;


  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    
    embryo_p = ptable.list[EMBRYO].head;
    while(embryo_p){
        if(embryo_p->parent == curproc)
            havekids = 1;
        current = embryo_p->next;
        embryo_p = current;
    }
    
    for(int i=0;i<MAXPRIO+1;++i){
        runnable_p = ptable.ready[i].head;
        while(runnable_p){
            if(runnable_p->parent == curproc)
                havekids = 1;
            current = runnable_p->next;
            runnable_p = current;
        }
    }

    running_p = ptable.list[RUNNING].head;
    while(running_p){
        if(running_p->parent == curproc)
            havekids = 1;
        current = running_p->next;
        running_p = current;
    }

    sleeping_p = ptable.list[SLEEPING].head;
    while(sleeping_p){
        if(sleeping_p->parent == curproc)
            havekids = 1;
        current = sleeping_p->next;
        sleeping_p = current;
    }

    zombie_p = ptable.list[ZOMBIE].head;
    while(zombie_p){
        if(zombie_p->parent == curproc){
            havekids = 1;
              // Found one.
            pid = zombie_p->pid;
            kfree(zombie_p->kstack);
            zombie_p->kstack = 0;
            freevm(zombie_p->pgdir);
            zombie_p->pid = 0;
            zombie_p->parent = 0;
            zombie_p->name[0] = 0;
            zombie_p->killed = 0;
            rc = stateListRemove(&ptable.list[ZOMBIE],zombie_p);
            if(rc < 0)
                panic("[ZOMBIE->UNUSED]:oh no!! I'm panicking!");
            assertState(zombie_p,ZOMBIE);
            zombie_p->state = UNUSED;
            stateListAdd(&ptable.list[UNUSED],zombie_p);
            release(&ptable.lock);
            return pid;
        }
        
        current = zombie_p->next;
        zombie_p = current;
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}



#elif defined(CS333_P3)
// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  struct proc * embryo_p;
  struct proc * runnable_p;
  struct proc * running_p;
  struct proc * sleeping_p;
  struct proc * zombie_p;
  int havekids,rc;
  uint pid;
  struct proc *curproc = myproc();
  struct proc * current;


  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    
    embryo_p = ptable.list[EMBRYO].head;
    while(embryo_p){
        if(embryo_p->parent == curproc)
            havekids = 1;
        current = embryo_p->next;
        embryo_p = current;
    }
    
    runnable_p = ptable.list[RUNNABLE].head;
    while(runnable_p){
        if(runnable_p->parent == curproc)
            havekids = 1;
        current = runnable_p->next;
        runnable_p = current;
    }

    running_p = ptable.list[RUNNING].head;
    while(running_p){
        if(running_p->parent == curproc)
            havekids = 1;
        current = running_p->next;
        running_p = current;
    }

    sleeping_p = ptable.list[SLEEPING].head;
    while(sleeping_p){
        if(sleeping_p->parent == curproc)
            havekids = 1;
        current = sleeping_p->next;
        sleeping_p = current;
    }

    zombie_p = ptable.list[ZOMBIE].head;
    while(zombie_p){
        if(zombie_p->parent == curproc){
            havekids = 1;
              // Found one.
            pid = zombie_p->pid;
            kfree(zombie_p->kstack);
            zombie_p->kstack = 0;
            freevm(zombie_p->pgdir);
            zombie_p->pid = 0;
            zombie_p->parent = 0;
            zombie_p->name[0] = 0;
            zombie_p->killed = 0;
            rc = stateListRemove(&ptable.list[ZOMBIE],zombie_p);
            if(rc < 0)
                panic("[ZOMBIE->UNUSED]:oh no!! I'm panicking!");
            assertState(zombie_p,ZOMBIE);
            zombie_p->state = UNUSED;
            stateListAdd(&ptable.list[UNUSED],zombie_p);
            release(&ptable.lock);
            return pid;
        }
        
        current = zombie_p->next;
        zombie_p = current;
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}



#else
// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  struct proc *p;
  int havekids;
  uint pid;
  struct proc *curproc = myproc();

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}

#endif

#ifdef CS333_P4
void
scheduler(void)
{
  struct proc *p;
  struct cpu *c = mycpu();
  c->proc = 0;
#ifdef PDX_XV6
  int idle;  // for checking if processor is idle
#endif // PDX_XV6

  for(;;){
    // Enable interrupts on this processor.
    sti();

#ifdef PDX_XV6
    idle = 1;  // assume idle unless we schedule a process
#endif // PDX_XV6
    acquire(&ptable.lock);
    if(ticks >= ptable.PromoteAtTime){
        for(int i=0;i<MAXPRIO+1;++i){
            ptable.PromoteAtTime = ticks + TICKS_TO_PROMOTE;
            promoteQueue(&ptable.ready[i]);
        }
        promoteProcess(&ptable.list[SLEEPING]);
        promoteProcess(&ptable.list[RUNNING]);
    }
    for(int i=0;i<MAXPRIO+1;++i){

        if(ptable.ready[i].head){
            p = ptable.ready[i].head;
            int rc = stateListRemove(&ptable.ready[i],p);
            if(rc < 0)
                panic("\n[RUNNABLE->RUNNING]:oh no!! I'm panicking!");
#ifdef PDX_XV6
            idle = 0;  // not idle this timeslice
#endif // PDX_XV6
            c->proc = p;
            switchuvm(p);
            assertState(p,RUNNABLE);
            p->state = RUNNING;
            stateListAdd(&ptable.list[RUNNING],p);
            swtch(&(c->scheduler), p->context);
            switchkvm();

#ifdef CS333_P2
            p->cpu_ticks_in = ticks;
#endif
            // Process is done running for now.
            // It should have changed its p->state before coming back.
            c->proc = 0;
        }
    }
    release(&ptable.lock);
    

#ifdef PDX_XV6
    // if idle, wait for next interrupt
    if (idle) {
      sti();
      hlt();
    }
#endif // PDX_XV6
  }
  
}




#elif defined(CS333_P3)
// Per-CPU process scheduler.
// Each CPU calls scheduler() after setting itself up.
// Scheduler never returns.  It loops, doing:
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
  struct proc *p;
  struct cpu *c = mycpu();
  c->proc = 0;
#ifdef PDX_XV6
  int idle;  // for checking if processor is idle
#endif // PDX_XV6

  for(;;){
    // Enable interrupts on this processor.
    sti();

#ifdef PDX_XV6
    idle = 1;  // assume idle unless we schedule a process
#endif // PDX_XV6
    acquire(&ptable.lock);
    if(ptable.list[RUNNABLE].head){
        p = ptable.list[RUNNABLE].head;
        int rc = stateListRemove(&ptable.list[RUNNABLE],p);
        if(rc < 0)
            panic("\n[RUNNABLE->RUNNING]:oh no!! I'm panicking!");
#ifdef PDX_XV6
        idle = 0;  // not idle this timeslice
#endif // PDX_XV6
        c->proc = p;
        switchuvm(p);
        assertState(p,RUNNABLE);
        p->state = RUNNING;
        stateListAdd(&ptable.list[RUNNING],p);
        swtch(&(c->scheduler), p->context);
        switchkvm();

#ifdef CS333_P2
        p->cpu_ticks_in = ticks;
#endif
        // Process is done running for now.
        // It should have changed its p->state before coming back.
        c->proc = 0;
    }
    release(&ptable.lock);
    

#ifdef PDX_XV6
    // if idle, wait for next interrupt
    if (idle) {
      sti();
      hlt();
    }
#endif // PDX_XV6
  }
  
}

#else

// Per-CPU process scheduler.
// Each CPU calls scheduler() after setting itself up.
// Scheduler never returns.  It loops, doing:
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
  struct proc *p;
  struct cpu *c = mycpu();
  c->proc = 0;
#ifdef PDX_XV6
  int idle;  // for checking if processor is idle
#endif // PDX_XV6

  for(;;){
    // Enable interrupts on this processor.
    sti();

#ifdef PDX_XV6
    idle = 1;  // assume idle unless we schedule a process
#endif // PDX_XV6
    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->state != RUNNABLE)
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
#ifdef PDX_XV6
      idle = 0;  // not idle this timeslice
#endif // PDX_XV6
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;
#ifdef CS333_P2
      p->cpu_ticks_in = ticks;
#endif
      swtch(&(c->scheduler), p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);
#ifdef PDX_XV6
    // if idle, wait for next interrupt
    if (idle) {
      sti();
      hlt();
    }
#endif // PDX_XV6
  }
}
#endif

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state. Saves and restores
// intena because intena is a property of this
// kernel thread, not this CPU. It should
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
#ifdef CS333_P2
  p->cpu_ticks_total += (ticks - p->cpu_ticks_in);
#endif
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
}

#ifdef CS333_P4
void
yield(void)
{
  struct proc *curproc = myproc();
  int rc,time_in,time_out,new_budget;

  acquire(&ptable.lock);  //DOC: yieldlock
  rc = stateListRemove(&ptable.list[RUNNING],curproc);
  if(rc < 0)
      panic("\n[RUNNING->RUNNABLE]:oh no!! I'm panicking!");
  assertState(curproc,RUNNING);
  curproc->state = RUNNABLE;
  time_out = ticks;
  time_in = curproc->cpu_ticks_in;
  new_budget = (time_out - time_in);
  curproc->budget -= new_budget;
  if(curproc->budget <= 0){
      curproc->budget = BUDGET;
      if(MAXPRIO == 0)
          curproc->priority = MAXPRIO;
      else if(curproc->priority > MAXPRIO)
          curproc->priority = MAXPRIO-1;
      else if(curproc->priority < MAXPRIO || curproc->priority == MAXPRIO)
          curproc->priority -= 1;
      stateListAdd(&ptable.ready[curproc->priority],curproc);
  }else{
  stateListAdd(&ptable.ready[curproc->priority],curproc);
  }
  sched();
  release(&ptable.lock);
}

#elif defined(CS333_P3)
void
yield(void)
{
  struct proc *curproc = myproc();
  int rc;

  acquire(&ptable.lock);  //DOC: yieldlock
  rc = stateListRemove(&ptable.list[RUNNING],curproc);
  if(rc < 0)
      panic("\n[RUNNING->RUNNABLE]:oh no!! I'm panicking!");
  assertState(curproc,RUNNING);
  curproc->state = RUNNABLE;
  stateListAdd(&ptable.list[RUNNABLE],curproc);
  sched();
  release(&ptable.lock);
}

#else
// Give up the CPU for one scheduling round.
void
yield(void)
{
  struct proc *curproc = myproc();

  acquire(&ptable.lock);  //DOC: yieldlock
  curproc->state = RUNNABLE;
  sched();
  release(&ptable.lock);
}
#endif

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}

#ifdef CS333_P4
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  int rc,new_ticks;

  if(p == 0)
    panic("sleep");

  // Must acquire ptable.lock in order to
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    if (lk) release(lk);
  }
  // Go to sleep.
  rc = stateListRemove(&ptable.list[RUNNING],p);
  if(rc < 0)
      panic("\n[RUNNING->SLEEPING]:oh no!! I'm panicking!");
  assertState(p,RUNNING);
  p->chan = chan;
  p->state = SLEEPING;
  stateListAdd(&ptable.list[SLEEPING],p);
  new_ticks = (ticks - p->cpu_ticks_in);
  p->budget -= new_ticks; 
  if(p->priority <= MAXPRIO && p->budget <=0){
      p->budget = BUDGET;
      p->priority -= 1;
  } else if(p->priority >= MAXPRIO)
      p->priority = MAXPRIO-1;
  sched();

  // Tidy up.
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    if (lk) acquire(lk);
  }
}

#elif defined(CS333_P3)
// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  int rc;

  if(p == 0)
    panic("sleep");

  // Must acquire ptable.lock in order to
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    if (lk) release(lk);
  }
  // Go to sleep.
  rc = stateListRemove(&ptable.list[RUNNING],p);
  if(rc < 0)
      panic("\n[RUNNING->SLEEPING]:oh no!! I'm panicking!");
  assertState(p,RUNNING);
  p->chan = chan;
  p->state = SLEEPING;
  stateListAdd(&ptable.list[SLEEPING],p);
  

  sched();

  // Tidy up.
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    if (lk) acquire(lk);
  }
}

#else
// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();

  if(p == 0)
    panic("sleep");

  // Must acquire ptable.lock in order to
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    if (lk) release(lk);
  }
  // Go to sleep.
  p->chan = chan;
  p->state = SLEEPING;

  sched();

  // Tidy up.
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    if (lk) acquire(lk);
  }
}
#endif

#ifdef CS333_P4
static void
wakeup1(void *chan)
{
  struct proc *p;
  struct proc * current;
  int rc;
 
  p = ptable.list[SLEEPING].head;
  while(p){
      if(p->state == SLEEPING && p->chan == chan){
          current = p->next;
          rc = stateListRemove(&ptable.list[SLEEPING],p);
          if(rc < 0)
                  panic("\n[SLEEPING->RUNNABLE]:oh no!! I'm panicking!");
          assertState(p,SLEEPING);
          p->state = RUNNABLE;
          stateListAdd(&ptable.ready[p->priority],p);
          p = current;
      }else{
          current = p->next;
          p = current;
      }
  }
  
}


#elif defined(CS333_P3)
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
  struct proc *p;
  struct proc * current;
  int rc;
 
  p = ptable.list[SLEEPING].head;
  while(p){
      if(p->state == SLEEPING && p->chan == chan){
          current = p->next;
          rc = stateListRemove(&ptable.list[SLEEPING],p);
          if(rc < 0)
                  panic("\n[SLEEPING->RUNNABLE]:oh no!! I'm panicking!");
          assertState(p,SLEEPING);
          p->state = RUNNABLE;
          stateListAdd(&ptable.list[RUNNABLE],p);
          p = current;
      }else{
          current = p->next;
          p = current;
      }
  }
  
}

#else
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}
#endif

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
}


#ifdef CS333_P4
int
kill(int pid)
{
  struct proc * current;
  // Define the 5 list pointers
  struct proc * embryo_check;
  struct proc * runnable_check;
  struct proc * running_check;
  struct proc * sleeping_check;
  struct proc * zombie_check;
  int rc;

  acquire(&ptable.lock);

  embryo_check = ptable.list[EMBRYO].head;
  while(embryo_check){
      if(embryo_check->pid == pid){
          embryo_check->killed = 1;
          release(&ptable.lock);
          return -1;
      }
      current = embryo_check->next;
      embryo_check = current;
  }

  for(int i=0;i<MAXPRIO+1;++i){
      runnable_check = ptable.ready[i].head;
      while(runnable_check){
          if(runnable_check->pid == pid){
              runnable_check->killed = 1;
              release(&ptable.lock);
              return -1;
          }
          current = runnable_check->next;
          runnable_check = current;
      }
  }

  running_check = ptable.list[RUNNING].head;
  while(running_check){
      if(running_check->pid == pid){
          running_check->killed = 1;
          release(&ptable.lock);
          return -1;
      }
      current = running_check->next;
      running_check = current;
  }

  sleeping_check = ptable.list[SLEEPING].head;
  while(sleeping_check){
      if(sleeping_check->pid == pid){
          sleeping_check->killed = 1;
          rc = stateListRemove(&ptable.list[SLEEPING],sleeping_check);
          if(rc < 0)
              panic("[SLEEPING->RUNNABLE]:oh no!! I'm panicking!");
          assertState(sleeping_check,SLEEPING);
          sleeping_check->state = RUNNABLE;
          stateListAdd(&ptable.ready[sleeping_check->priority],sleeping_check);
          release(&ptable.lock);
          return 0;
      }
      current = sleeping_check->next;
      sleeping_check = current;
  }

  zombie_check = ptable.list[ZOMBIE].head;
  while(zombie_check){
      if(zombie_check->pid == pid){
          zombie_check->killed = 1;
          release(&ptable.lock);
          return -1;
      }
      current = zombie_check->next;
      zombie_check = current;
  }

  release(&ptable.lock);
  return -1;
}


#elif defined(CS333_P3)
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
  struct proc * current;
  // Define the 5 list pointers
  struct proc * embryo_check;
  struct proc * runnable_check;
  struct proc * running_check;
  struct proc * sleeping_check;
  struct proc * zombie_check;
  int rc;

  acquire(&ptable.lock);
  embryo_check = ptable.list[EMBRYO].head;
  while(embryo_check){
      if(embryo_check->pid == pid){
          embryo_check->killed = 1;
          release(&ptable.lock);
          return -1;
      }
      current = embryo_check->next;
      embryo_check = current;
  }

  runnable_check = ptable.list[RUNNABLE].head;
  while(runnable_check){
      if(runnable_check->pid == pid){
          runnable_check->killed = 1;
          release(&ptable.lock);
          return -1;
      }
      current = runnable_check->next;
      runnable_check = current;
  }

  running_check = ptable.list[RUNNING].head;
  while(running_check){
      if(running_check->pid == pid){
          running_check->killed = 1;
          release(&ptable.lock);
          return -1;
      }
      current = running_check->next;
      running_check = current;
  }

  sleeping_check = ptable.list[SLEEPING].head;
  while(sleeping_check){
      if(sleeping_check->pid == pid){
          sleeping_check->killed = 1;
          rc = stateListRemove(&ptable.list[SLEEPING],sleeping_check);
          if(rc < 0)
              panic("[SLEEPING->RUNNABLE]:oh no!! I'm panicking!");
          assertState(sleeping_check,SLEEPING);
          sleeping_check->state = RUNNABLE;
          stateListAdd(&ptable.list[RUNNABLE],sleeping_check);
          release(&ptable.lock);
          return 0;
      }
      current = sleeping_check->next;
      sleeping_check = current;
  }

  zombie_check = ptable.list[ZOMBIE].head;
  while(zombie_check){
      if(zombie_check->pid == pid){
          zombie_check->killed = 1;
          release(&ptable.lock);
          return -1;
      }
      current = zombie_check->next;
      zombie_check = current;
  }

  release(&ptable.lock);
  return -1;
}

#else
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
#endif
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.

void
procdump(void)
{
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

#ifdef CS333_P4
  int seconds, m_seconds, cpu_sec, cpu_milli_sec;
#elif defined(CS333_P2)
  int seconds, m_seconds, cpu_sec, cpu_milli_sec;
  
#elif defined(CS333_P1)
  int seconds,m_seconds;
#endif

#ifdef CS333_P4
  cprintf("PID\tName\tUID\tGID\tPPID\tPrio\tElapsed\t  CPU\tState\tSize\tPCs\n");
#elif defined(CS333_P2)
  cprintf("PID\tName\tUID\tGID\tPPID\tElapsed\t  CPU\tState\tSize\tPCs\n");
#elif defined(CS333_P1)
  cprintf("PID\tName\t Elapsed  State  Size\t PCs\n");
#else
  cprintf("PID\tName\tState\n");
#endif

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";

#ifdef CS333_P4
    seconds = (ticks-p->start_ticks)/1000; 
    m_seconds = (ticks-p->start_ticks)%1000;
    cpu_sec = p->cpu_ticks_total/1000;
    cpu_milli_sec = p->cpu_ticks_total%1000;
    cprintf("  %d\t%s\t%d\t%d\t%d\t%d\t %d.%d\t %d.%d\t%s %d\t%d\t", p->pid, p->name, p->uid, p->gid, p->parent->pid,p->priority, seconds, m_seconds,cpu_sec, cpu_milli_sec,state, p->sz);
#elif defined(CS333_P2)
    cpu_sec = p->cpu_ticks_total/1000;
    cpu_milli_sec = p->cpu_ticks_total%1000;

    seconds = (ticks-p->start_ticks)/1000; 
    m_seconds = (ticks-p->start_ticks)%1000;
    cprintf("  %d\t%s\t%d\t%d\t%d\t %d.%d\t  %d.%d\t %s %d\t%d\t", p->pid, p->name, p->uid, p->gid, p->parent->pid, seconds, m_seconds,cpu_sec, cpu_milli_sec,state, p->sz);
#elif defined (CS333_P1)
    seconds = (ticks-p->start_ticks)/1000; 
    m_seconds = (ticks-p->start_ticks)%1000;
    cprintf("  %d\t%s\t %d.%d\t  %s %d\t", p->pid, p->name, seconds,m_seconds,state,p->sz);
#else
    cprintf("  %d\t%s\t%s\t", p->pid, p->name,state);
#endif
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
#ifdef CS333_p4
int
getprocs(uint max, struct uproc * table){
    int count = 0;
    struct  proc * p;
    acquire(&ptable.lock);

    for(p = ptable.proc; p < &ptable.proc[NPROC] && count < max; ++p){
        if(max < count)
            break;
        if(p->state == RUNNABLE || p->state == RUNNING || p->state == SLEEPING){
            table[count].pid = p->pid;
            table[count].gid = p->gid;
            table[count].uid = p->uid;

            if(p -> parent == 0){
                table[count].ppid = p->pid;
            
            }else{
                table[count].ppid = p -> parent -> pid;
            }

            table[count].elapsed_ticks = ticks - p->start_ticks;
            table[count].CPU_total_ticks = p->cpu_ticks_total;
            safestrcpy(table[count].state, states[p->state], sizeof(table[count].state));
            table[count].size = p->sz;
            table[count].priority = p->priority; // add the priority of the proc
            safestrcpy(table[count].name, p->name, sizeof(table[count].name));

            ++count;
        }
    }
    release(&ptable.lock);
    return count;
}

#elif defined(CS333_P2)
int
getprocs(uint max, struct uproc * table){
    int count = 0;
    struct  proc * p;
    acquire(&ptable.lock);

    for(p = ptable.proc; p < &ptable.proc[NPROC] && count < max; ++p){
        if(max < count)
            break;
        if(p->state == RUNNABLE || p->state == RUNNING || p->state == SLEEPING){
            table[count].pid = p->pid;
            table[count].gid = p->gid;
            table[count].uid = p->uid;

            if(p -> parent == 0){
                table[count].ppid = p->pid;
            
            }else{
                table[count].ppid = p -> parent -> pid;
            }

            table[count].elapsed_ticks = ticks - p->start_ticks;
            table[count].CPU_total_ticks = p->cpu_ticks_total;
            safestrcpy(table[count].state, states[p->state], sizeof(table[count].state));
            table[count].size = p->sz;
            safestrcpy(table[count].name, p->name, sizeof(table[count].name));

            ++count;
        }
    }
    release(&ptable.lock);
    return count;
}
#endif

#ifdef CS333_P4
static void
initProcessLists()
{
    int i;
    for(i = UNUSED; i <= ZOMBIE; i++){
        ptable.list[i].head = NULL;
        ptable.list[i].tail = NULL;
    }
   for(i = 0; i <= MAXPRIO; i++){
        ptable.ready[i].head = NULL;
        ptable.ready[i].tail = NULL;
    }  
}

static void initFreeList(void)
{
    struct proc * p;

    for(p = ptable.proc; p < ptable.proc + NPROC; ++p){
        p->state = UNUSED;
        stateListAdd(&ptable.list[UNUSED],p);
    }

}

static void
stateListAdd(struct ptrs* list, struct proc * p)
{

    if((*list).head == NULL){
        (*list).head = p;
        (*list).tail = p;
        p->next = NULL;
    }else{
        ((*list).tail)->next = p;
        (*list).tail = ((*list).tail)->next;
        ((*list).tail)->next = NULL;
    }
}

static int
stateListRemove(struct ptrs * list,struct proc * p)
{

    if((*list).head == NULL || (*list).tail == NULL || p == NULL){
        return -1;
    }

    struct proc * current = (*list).head;
    struct proc * previous = 0;

    if(current == p){
        (*list).head = ((*list).head)->next;
        // prevent tail remaining assigned when we've removed the only item
        // on the list
        if((*list).tail == p){
            (*list).tail = NULL;
        }
        return 0;
    }

    while(current){
        if(current == p){
            break;
        }
        
        previous = current;
        current = current->next;
    }

    // Process not found. Return error
    if(current == NULL){
        return -1;
    }

    // Process found
    if(current == (*list).tail){
        (*list).tail = previous;
        ((*list).tail)->next = NULL;
    }else{
        previous->next = current->next;
    }

    // make sure p->next doesn't point to the list
    p->next = NULL;

    return 0;
}
static int
promoteQueue(struct ptrs*readyList)
{
    struct proc * current;
    if((*readyList).head == NULL)
        return 0;
    current = (*readyList).head;
    while(current){
        if(current != NULL && current->priority < MAXPRIO){
            stateListRemove(&ptable.ready[current->priority],current);
            current->priority += 1;
            stateListAdd(&ptable.ready[current->priority],current);
        }
        current = current->next;
    }

    return 0;
}
static int
promoteProcess(struct ptrs*list)
{
    struct proc * current;
    if((*list).head == NULL)
        return 0;

    current = (*list).head;
    while(current){
        if(current != NULL && current->priority < MAXPRIO)
            current->priority += 1;
        current = current->next;
    }
    return 0;
}
static void
assertState(struct proc* p,enum procstate state)
{


    if(p->state != state){
        panic("ASSERT FAILED: proc->state != state");
    }else{
        return;
    }
}


void
control_f()
{
    int counter = 0;
    struct proc * free_ptr = ptable.list[UNUSED].head; 


    if(!free_ptr){
        cprintf("Free List is empty!",'\n');
        return;
    }

    while(free_ptr){
        counter += 1;
        free_ptr = free_ptr->next;
    }

    cprintf("Free List:\t%d Processes",counter,'\n');
}

void
control_r()
{
    struct proc * ready_ptr;

    if(ptable.ready){
        cprintf("Number of Queues:%d\n",MAXPRIO);
        for(int i=MAXPRIO;i>=0;--i){
            ready_ptr = ptable.ready[i].head;
            if(ready_ptr == NULL){
                cprintf("Queue is empty!\n");
            }else{
            cprintf("Queue #%d:\t",i);
            while(ready_ptr->next != NULL){
                cprintf("(%d,%d) ->",ready_ptr->pid,ready_ptr->budget);
                ready_ptr = ready_ptr->next;
            }
            }if(ready_ptr)
                cprintf("(%d,%d) ->",ready_ptr->pid,ready_ptr->budget,'\n');
        }
    }
}

void
control_s()
{
    struct proc * sleep_ptr = ptable.list[SLEEPING].head;

    if(!sleep_ptr){
        cprintf("Sleep List is empty!\n");
        return;
    }

    cprintf("Sleep List:\t");
    while(sleep_ptr){
        if(sleep_ptr->next)
            cprintf("%d ->",sleep_ptr->pid,'\n');
        else
            cprintf("%d->",sleep_ptr->pid,'\n');
        sleep_ptr = sleep_ptr->next;
    }
}

void
control_z()
{
    struct proc * zombie_ptr = ptable.list[ZOMBIE].head;

    if(!zombie_ptr){
        cprintf("Zombie List is empty!\n");
        return;
    }

    cprintf("Zombie List:\t");
    while(zombie_ptr){
        if(zombie_ptr->next)
            cprintf("(%d,%d)->",zombie_ptr->pid,zombie_ptr->parent->pid,'\n');
        else
            cprintf("(%d,%d)->",zombie_ptr->pid,zombie_ptr->parent->pid,'\n');
        zombie_ptr = zombie_ptr->next;
    }
}

static int
findProc(struct proc *p,int pid, int priority)
{
    if(p == NULL)
        return -1;
    while(p){
        if(p->pid == pid){
            p->priority = priority;
            p->budget = BUDGET;
            release(&ptable.lock);
            return 1;
        }
        p = p->next;
    }
    return 0;
}
int
setpriority(int pid,int priority)
{
    struct proc * current;
    struct proc * sleeping_cur;
    struct proc * running_cur;
    if(pid < 0 || pid > NPROC)
        return -1;
    if(priority < 0 || priority > MAXPRIO)
        return -1;
    acquire(&ptable.lock);
    for(int i=0;i<MAXPRIO+1;++i){
        current = ptable.ready[i].head;
        while(current){
            if(current->pid == pid){
                stateListRemove(&ptable.ready[current->priority],current);
                current->priority = priority;
                current->budget = BUDGET;
                assertState(current,RUNNABLE);
                stateListAdd(&ptable.ready[current->priority],current);
                release(&ptable.lock);
                return 0;
            }
            current = current->next;
        }
    }
    if(ptable.list[SLEEPING].head){
        sleeping_cur = ptable.list[SLEEPING].head;
        if(findProc(sleeping_cur,pid,priority) == 1)
            return 0;
    }
    if(ptable.list[RUNNING].head){
        running_cur = ptable.list[RUNNING].head;
        if(findProc(running_cur,pid,priority) == 1)
            return 0;
    }
    release(&ptable.lock);
    return 0;

}
int
getpriority(int pid)
{
    struct proc * current;
    if(pid < 0 || pid > NPROC)
        return 0;
    for(int i=0;i<MAXPRIO+1;++i){
        current = ptable.ready[i].head;
        while(current){
            if(current->pid == pid)
                return current->priority;
            current = current->next;
        }
    }
    return -1;
}
#elif defined(CS333_P3)
static void
initProcessLists()
{
    int i;
    for(i = UNUSED; i <= ZOMBIE; i++){
        ptable.list[i].head = NULL;
        ptable.list[i].tail = NULL;
    }
#ifdef CS333_P4
   for(i = 0; i <= MAXPRIO; i++){
        ptable.ready[i].head = NULL;
        ptable.ready[i].tail = NULL;
    }  
#endif
}

static void initFreeList(void)
{
    struct proc * p;

    for(p = ptable.proc; p < ptable.proc + NPROC; ++p){
        p->state = UNUSED;
        stateListAdd(&ptable.list[UNUSED],p);
    }

}

static void
stateListAdd(struct ptrs* list, struct proc * p)
{

    if((*list).head == NULL){
        (*list).head = p;
        (*list).tail = p;
        p->next = NULL;
    }else{
        ((*list).tail)->next = p;
        (*list).tail = ((*list).tail)->next;
        ((*list).tail)->next = NULL;
    }
}

static int
stateListRemove(struct ptrs * list,struct proc * p)
{

    if((*list).head == NULL || (*list).tail == NULL || p == NULL){
        return -1;
    }

    struct proc * current = (*list).head;
    struct proc * previous = 0;

    if(current == p){
        (*list).head = ((*list).head)->next;
        // prevent tail remaining assigned when we've removed the only item
        // on the list
        if((*list).tail == p){
            (*list).tail = NULL;
        }
        return 0;
    }

    while(current){
        if(current == p){
            break;
        }
        
        previous = current;
        current = current->next;
    }

    // Process not found. Return error
    if(current == NULL){
        return -1;
    }

    // Process found
    if(current == (*list).tail){
        (*list).tail = previous;
        ((*list).tail)->next = NULL;
    }else{
        previous->next = current->next;
    }

    // make sure p->next doesn't point to the list
    p->next = NULL;

    return 0;
}


static void
assertState(struct proc* p,enum procstate state)
{


    if(p->state != state){
        panic("ASSERT FAILED: proc->state != state");
    }else{
        return;
    }
}


void
control_f()
{
    int counter = 0;
    struct proc * free_ptr = ptable.list[UNUSED].head; 


    if(!free_ptr){
        cprintf("Free List is empty!");
        return;
    }

    while(free_ptr){
        counter += 1;
        free_ptr = free_ptr->next;
    }

    cprintf("Free List:\t%d Processes",counter);
}

void
control_r()
{
    struct proc * ready_ptr = ptable.list[RUNNABLE].head;

    if(!ready_ptr){
        cprintf("Ready List is empty!");
        return;
    }

    cprintf("Ready List:\t");
    while(ready_ptr){
        if(ready_ptr->next)
            cprintf("%d ->",ready_ptr->pid);
        else
            cprintf("%d->",ready_ptr->pid);
        ready_ptr = ready_ptr->next;
    }
}

void
control_s()
{
    struct proc * sleep_ptr = ptable.list[SLEEPING].head;

    if(!sleep_ptr){
        cprintf("Sleep List is empty!");
        return;
    }

    cprintf("Sleep List:\t");
    while(sleep_ptr){
        if(sleep_ptr->next)
            cprintf("%d ->",sleep_ptr->pid);
        else
            cprintf("%d->",sleep_ptr->pid);
        sleep_ptr = sleep_ptr->next;
    }
}

void
control_z()
{
    struct proc * zombie_ptr = ptable.list[ZOMBIE].head;

    if(!zombie_ptr){
        cprintf("Zombie List is empty!");
        return;
    }

    cprintf("Zombie List:\t");
    while(zombie_ptr){
        if(zombie_ptr->next)
            cprintf("(%d,%d)->",zombie_ptr->pid,zombie_ptr->parent->pid);
        else
            cprintf("(%d,%d)->",zombie_ptr->pid,zombie_ptr->parent->pid);
        zombie_ptr = zombie_ptr->next;
    }
}
#endif
