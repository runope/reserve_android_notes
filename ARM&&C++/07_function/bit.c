#include <stdio.h>


int main(int argc, char const *argv[])
{
    int n1 = 0x100;
    int n2 = ~n1;
    int n3 = n1 & n2;
    int n4 = n1 ^ n3;
    int n5 = n1 >> 1;
    int n6 = n1 << 1;
    int n7 = n1 | n2;
    
    return 0;
}