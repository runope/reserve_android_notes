#include <stdio.h>


int main(int argc, char const *argv[])
{
    static int n = 222;
    int n1 = 5;
    n = n1;
    
    return 0;
}
