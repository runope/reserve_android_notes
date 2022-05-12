#include <stdio.h>

int main() {

    int n = 3;
    switch (n) {
        case 1:
            printf("case 1\r\n");
            break;
        case 2:
            printf("case 2\r\n");
            break;
        case 3:
            printf("case 3\r\n");
            break;
        case 4:
            printf("case 4\r\n");
            break;
        
        default:
            printf("case default\r\n");
            break;
    }

    return 0;
}