#include <stdio.h>

class CNumber {
public:
    int num1;
    int num2;
    int num3;

    CNumber() {
        num3 = 3;
    }

    int getNum2() {
        return this->num2;
    }
};

// 定义全局变量的关键点是，全局的构造函数在.init_array段中执行
CNumber cnumber_global;

int main(int argc, char const * argv[]) {
    CNumber cnumber;    
    cnumber.num1 = 1;
    cnumber.num2 = 2;

    return cnumber.num3;
}