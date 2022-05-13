#include <stdio.h>

class CNumber {
public:
    int num1;
    int num2;
    int num3;
};

int main(int argc, char const * argv[]) {
    CNumber cnumber;
    cnumber.num1 = 1;

    return cnumber.num1;
}