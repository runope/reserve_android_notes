#include <stdio.h>

class CNumber {
public:
    int num1;
    int num2;
    int num3;

    CNumber() {
        num3 = 3;
    }

    ~CNumber() {
        printf("destructor\n");
    }

    int getNum2() {
        return this->num2;
    }
};

// 定义全局变量的关键点是，全局的构造函数在.init_array段中执行
// 全局变量的析构函数会注册到__cxa_atexit。__cxa_atexit 注册在调用 exit 时或动态链接库(或共享库) 被卸载时执行的函数
CNumber cnumber_global;

int main(int argc, char const * argv[]) {
    CNumber cnumber;    
    cnumber.num1 = 1;
    cnumber.num2 = 2;

    return cnumber.num3;
}