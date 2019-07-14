#ifdef CS333_P5
#include "types.h"
#include "user.h"

int atoo(const char * s);

int
main(int argc,char * argv[])
{
    if(argc < 3 || argc > 3){
        printf(1,"Incorrect number of Arguments!\n");
        exit();
    }
    chmod(argv[2],atoo(argv[1]));
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
