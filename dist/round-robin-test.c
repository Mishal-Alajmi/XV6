#include "types.h"
#include "user.h"



int 
main(void)
{
    int pid;
    for(int i=0;i<20;++i){
        pid = fork();
        if(!pid)
            while(1);
    }

    if(pid){
        for(int j=0;j<20;++j){
            wait();
        }
    }
    exit();
}
