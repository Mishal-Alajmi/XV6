#ifdef CS333_P5
#include "types.h"
#include "user.h"

int
main(int argc, char * argv[])
{
    if(argc < 3 || argc > 3){
        printf(1,"Incorrect number of Arguments");
        exit();
    }
    chown(argv[2],atoi(argv[1]));
    exit();
}

#else
#include "types.h"
#include "user.h"

int
main(void)
{
    printf(1,"System Call not Implemented!\n");
    exit();
}

#endif
