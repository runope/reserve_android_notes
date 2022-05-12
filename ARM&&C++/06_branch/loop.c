#include <stdio.h>


int main(int argc, char const *argv[])
{
    for (int i = 0; i < 20; i++)
    {
        printf("for i : %d\r\n", i);
    }
    int j = 30;
    while (j)
    {
        printf("while j : %d\r\n", j);
        j--;
    }
    int k = 40;
    do
    {
       printf("do while k : %d\r\n", k--);

    } while (k);
    

    return 0;
}
