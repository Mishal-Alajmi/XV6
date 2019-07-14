#ifdef CS333_P2
#include "types.h"
#include "user.h"

int
main(int argc, char * argv[]){
    int pid = fork();
    int start_t, end_t, seconds, millisec;

    start_t = uptime();

    if(pid == 0){

        if(argc == 1){
            exit();
        }

        ++argv; // skip the first arg
        if(exec(argv[0],argv)){
            printf(1,"exec failed!");
            exit();
        }
    }

    if(pid < 0){
        printf(1,"Fork Failed");
        exit();
    }


    wait();
    end_t = uptime();
    seconds = (end_t - start_t)/1000;
    millisec = (end_t - start_t)%1000; 

    if(!argv[1]){
        printf(1, "Ran in: %d.%d\n",seconds,millisec);
    }

    else{
        printf(1,"%s ran in: %d.%d\n",argv[0],seconds,millisec);
    } 
    exit();
}
#endif
