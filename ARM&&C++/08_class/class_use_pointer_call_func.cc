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
    // 虚函数, 主要是存在虚表
    //      虚表 构造和析构函数中，把虚表地址存在对象的0地址上，虚表中有虚函数的地址
    //      ida 静态分析在Structures中添加虚表的结构体， 在代码的地方按T把偏移转成结构体（使用->指针对函数进行调用时）
    virtual void setNum3(int n) {
        num3 = n;
    }
    virtual int getNum3() {
        return num3;
    }
};

// 定义全局变量的关键点是，全局的构造函数在.init_array段中执行
// 全局变量的析构函数会注册到__cxa_atexit。__cxa_atexit 注册在调用 exit 时或动态链接库(或共享库) 被卸载时执行的函数
CNumber cnumber_global;

int main(int argc, char const * argv[]) {
    CNumber cnumber;    
    cnumber.num1 = 1;
    cnumber.num2 = 2;

    CNumber* pCNumber = &cnumber;

    // 使用->指针对函数进行调用时，代码中B跳转时是一个寄存器计算的值，可以使用创建结构体，
    // 然后在代码上按T，方便分析
    pCNumber->setNum3(100);
    return pCNumber->getNum3();
}

// 编译时加-static-libstdc++，将libstdc++以静态链接库连结