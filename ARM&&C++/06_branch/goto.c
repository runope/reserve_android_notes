#include <stdio.h>

int main() {

    int n = 3;

    if(n | 3)
goto Label1;

    int b = n + 3;

Label1:
    return 0;
}

// clang -target arm-linux-android21 -S  .\goto.c -o0 .\goto_arm_o0.s关闭优化