#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "uproc.h"
#ifdef PDX_XV6
#include "pdx-kernel.h"
#endif // PDX_XV6



// Define the prototype here, so it doesn't cause any errors with sys_getprocs()
int getprocs(int, struct uproc*);


int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      return -1;
    }
    sleep(&ticks, (struct spinlock *)0);
  }
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  xticks = ticks;
  return xticks;
}

#ifdef PDX_XV6
// Turn off the computer
int
sys_halt(void)
{
  cprintf("Shutting down ...\n");
  outw( 0x604, 0x0 | 0x2000);
  return 0;
}
#endif // PDX_XV6

#ifdef CS333_P1
int
sys_date(void)
{
    struct rtcdate *d;

    if(argptr(0, (void*)&d, sizeof(struct rtcdate)) < 0){
        return -1;
    } else{
        cmostime(d);
        return 0;
    }
}
#endif

#ifdef CS333_P2
int
sys_getuid(void){
    return myproc()->uid;
}

int
sys_getgid(void){
    return myproc()->gid;
}

int
sys_getppid(void){
    return myproc()->parent->pid;
}

int
sys_setuid(void){
    
    int uid;
    
    if(argint(0 ,&uid) < 0) 
       return -1;
    
    if(uid < 0 || uid > 32767)
       return -1;
    
    myproc()->uid = uid;
    return 0;
}

int
sys_setgid(void){

    int gid;

    if(argint(0, &gid) < 0)
        return -1;
    
    if(gid < 0 || gid > 32767)
        return -1;

    myproc()->gid = gid;
    return 0;
}


int
sys_getprocs(void){
    int max;
    struct uproc * ptable;

    if(argint(0, &max)<0)
        return -1;

    if(argptr(1, (void*)&ptable, sizeof(struct uproc) * max) < 0)
        return -1;
    
    return getprocs(max, ptable);
}
#endif

#ifdef CS333_P4
int
sys_setpriority(void)
{
    int pid,priority;

    if(argint(0,&pid)<0)
        return -1;
    if(argint(1,&priority)<0)
        return -1;
    return setpriority(pid,priority);
}

int
sys_getpriority(void)
{
    int pid;
    if(argint(0,&pid)<0)
        return -1;
    return getpriority(pid);
}
#endif
