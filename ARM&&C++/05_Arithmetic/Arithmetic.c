#include <stdio.h>

int main(int argc, char **argv) {
    char ch1 = 'a';
    char ch2 = 'b';

    short s1 = 0x10;
    short s2 = 0x20;

    int i1 = 0x100;
    int i2 = 0x200;

    char ch3 = ch1 + ch2;
    short s3 = s1 - s2;
    int i3 = i1 * i2;
    
    i3 = 0x1000;
    int i4 = i3 % 7;
}