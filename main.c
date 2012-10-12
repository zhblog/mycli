#include <stdio.h>

extern void start_cli(char *cmd, FILE *fp);

int main(int argc, char *argv[])
{
    start_cli(NULL,NULL);
    return 0;
}
