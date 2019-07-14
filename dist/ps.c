#include "types.h"
#include "user.h"
#include "uproc.h"

#define STR_MAX 16

int
main(int argc, char * argv[]){
    uint max = STR_MAX;
    uint sec,millisec,cpu_sec,cpu_millisec;
    struct uproc * ptable = malloc(max * sizeof(struct uproc));
    int count = getprocs(max,ptable);


    printf(1,"\nmax=%d",max);

    for(int i=0;i < count;++i){
        sec = ptable[i].elapsed_ticks/1000;
        millisec = ptable[i].elapsed_ticks%1000;

        cpu_sec = ptable[i].CPU_total_ticks/1000;
        cpu_millisec = ptable[i].CPU_total_ticks%1000;

#ifdef CS333_P4
        printf(1,"\nPID\tName\tUID\tGID\tPPID\tPrio\tElapsed\tCPU\tState\tSize\n");
        printf(1, "%d\t%s\t%d\t%d\t%d\t%d\t%d.%d\t%d.%d\t%s\t%d\n", ptable[i].pid, ptable[i].name, ptable[i].uid, ptable[i].gid, ptable[i].ppid, ptable[i].priority, sec, millisec, cpu_sec, cpu_millisec, ptable[i].state, ptable[i].size);
#elif defined(CS333_P2)
        printf(1,"\nPID\tName\tUID\tGID\tPPID\tElapsed\tCPU\tState\tSize\n");
        printf(1, "%d\t%s\t%d\t%d\t%d\t%d.%d\t%d.%d\t%s\t%d\n", ptable[i].pid, ptable[i].name, ptable[i].uid, ptable[i].gid, ptable[i].ppid, sec, millisec, cpu_sec, cpu_millisec, ptable[i].state, ptable[i].size);
#endif
    }
    free(ptable);
    exit();
}
