#include <stdio.h>

class CNumber {
public:
    int num1;
    int num2;
    int num3;

    int getNum2() {
        return this->num2;
    }
};

int main(int argc, char const * argv[]) {
    CNumber cnumber;
    cnumber.num1 = 1;
    cnumber.num2 = 2;


    return cnumber.getNum2();
}