#include <stdio.h>


void func_arg_type(char ch, short s, int n, int f, int d, int n2, int n3) {
    printf("%c %d %d %d %d\r\n", ch, s, n, f, d);
}


int main(int argc, char const *argv[])
{

    func_arg_type('a', 10, 1000, 123, 456, 200, 300);
    
    return 0;
}
