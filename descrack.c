#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>

char data[37] = "abcdefghijklmnopqrstuvwxyz0123456789";
char *goalPass = "$1$AAODv...$gXPqGkIO3Cu6dnclE";
char mypwd[10];
int minlen = 1; //min password length
int maxlen = 3; //max password length
 

void subgenerate(int index, int pwdlen)
{
        if (index == pwdlen)
                return;
        int i;
        for (i = 0; i < 36; i++)
        {
                mypwd[index] = data[i];
                memset(mypwd + index + 1, data[0], pwdlen- index -1);
                if (i != 0)
                {
//                     printf("%s      ",mypwd);
                        if (!strcmp(goalPass, crypt(mypwd, "$1$AAODv...$")))
                        {
                                printf("find password:%s", mypwd);
                                exit(0);
                        }
                }
                subgenerate(index + 1, pwdlen);
        }
}

void generate(int pwdlen, int start, int end)
{
        int i;
        for (i = start; i < end; i++) // 多线程可分段
        {
                mypwd[0] = data[i];
                memset(mypwd + 1, data[0], pwdlen-1); //填充长度
//              printf("%s      ",mypwd);
                if (!strcmp(goalPass, crypt(mypwd, "$1$AAODv...$")))
                {
                        printf("find password:%s", mypwd);
                        exit(0);
                }
                subgenerate(1, pwdlen);
        }
}


int main()
{
        char mypwd[10];
        if (maxlen > 9) puts("max password length must little then 9");
        int i，threadnum = 10;
        for (i = minlen; i <= maxlen; i++)
        {
                printf("/npassword length:%d/n", i);
                //password length
                memset(mypwd, 0, 10);
                generate(i,0,36); //留作多线程
        }

        puts("password not found");
        return 0;
}
更多
