#define NPROC        64  // maximum number of processes
#define KSTACKSIZE 4096  // size of per-process kernel stack
#define NCPU          8  // maximum number of CPUs
#define NOFILE       16  // open files per process
#define NFILE       100  // open files per system
#define NINODE       50  // maximum number of active i-nodes
#define NDEV         10  // maximum major device number
#define ROOTDEV       1  // device number of file system root disk
#define MAXARG       32  // max exec arguments
#define MAXOPBLOCKS  10  // max # of blocks any FS op writes
#define LOGSIZE      (MAXOPBLOCKS*3)  // max data blocks in on-disk log
#define NBUF         (MAXOPBLOCKS*3)  // size of disk block cache
#ifdef PDX_XV6
#define FSSIZE       2000  // size of file system in blocks
#else
#define FSSIZE       1000  // size of file system in blocks
#endif // PDX_XV6
#define UID          0 // set default UID value. Also used for Project_5
#define GID          0 // set default GID value. Also used for Project_5
#define MAXPRIO      10 // Set the default priority value for all procs to 300
#define BUDGET       300
#define TICKS_TO_PROMOTE   3000 // Set the initial time to promotion to 3000
#define DEFAULT_MODE    0755
