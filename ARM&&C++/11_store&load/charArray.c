#include <stdio.h>

int main(int argc, char **argv) {
    char* a[100];
    sprintf(a, "Hello, world!");

    char* b[100];

    strcpy(b,a);

    *(b + 4) = 'o';
    printf("%s", b);
    return 0;
}