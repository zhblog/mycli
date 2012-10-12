#include <stdlib.h>

#include "rpc_cli.h"

int cli_action(){
    printf("FILE:%s\nFUNCTION：%s\nLine %d:\n", __FILE__, __FUNCTION__, __LINE__);
    return 0;
}

int cli_action_1(int num){
    printf("num:%d\n",num);
    printf("FILE:%s\nFUNCTION：%s\nLine %d:\n", __FILE__, __FUNCTION__, __LINE__);
    return 0;
}

