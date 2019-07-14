struct uproc;
struct stat;
struct rtcdate;

// system calls
int fork(void);
int exit(void) __attribute__((noreturn));
int wait(void);
int pipe(int*);
int write(int, void*, int);
int read(int, void*, int);
int close(int);
int kill(int);
int exec(char*, char**);
int open(char*, int);
int mknod(char*, short, short);
int unlink(char*);
int fstat(int fd, struct stat*);
int link(char*, char*);
int mkdir(char*);
int chdir(char*);
int dup(int);
int getpid(void);
char* sbrk(int);
int sleep(int);
int uptime(void);
int halt(void);

#ifdef CS333_P1
int date(struct rtcdate*);
#endif

#ifdef CS333_P2
uint getgid(void);
int setgid(uint);
uint getuid(void);
int setuid(uint);
uint getppid(void);
int getprocs(uint max, struct uproc * table);
#endif

#ifdef CS333_P4
int setpriority(int,int);
int getpriority(int);
#endif

#ifdef CS333_P5
int chmod(char * pathname,int mode);
int chown(char * pathname,int owner);
int chgrp(char * pathname,int group);
#endif

// ulib.c
int stat(char*, struct stat*);
char* strcpy(char*, char*);
void *memmove(void*, void*, int);
char* strchr(const char*, char c);
int strcmp(const char*, const char*);
void printf(int, char*, ...);
char* gets(char*, int max);
uint strlen(char*);
void* memset(void*, int, uint);
void* malloc(uint);
void free(void*);
int atoi(const char*);
int atoo(const char*);
