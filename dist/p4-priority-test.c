#include "types.h"
#include "user.h"

int
main(int argc, char * argv[])
{
    int pid,priority,set_rc,get_rc;

    if(argv[1] && argv[2]){
        pid = atoi(argv[1]);
        priority = atoi(argv[2]);

        set_rc = setpriority(pid,priority);
        if(set_rc == -1)
            printf(1,"values out of bound!");
        else
            printf(1,"priority set to#%d",priority);

        get_rc = getpriority(pid);
        if(get_rc == -1)
            printf(1,"value out of bound!");
        else if(get_rc == priority)
            printf(1,"process found with pid#%d, and priority#%d",pid,get_rc);
    }

    exit();
}
