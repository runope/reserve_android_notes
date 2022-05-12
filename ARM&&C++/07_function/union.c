#include <stdio.h>


int main(int argc, char const *argv[])
{
    // union联合体占用的内存等于最长的成员占用的内存。联合体使用了内存覆盖，
    // 同一时刻只能保存一个成员的值，如果对新的成员赋值，就会把原来成员的值覆盖掉
    union union_u {
        int n1;
        int n2;
        short s3;
    };
    union union_u u = {0};
    u.n1 = 7;
    
    printf("%d\r\n", u.n2);
}