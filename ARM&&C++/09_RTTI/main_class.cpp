//继承
//  继承成员变量
//  继承成员函数
//覆盖
//  覆盖成员函数
//  覆盖成员变量
//重载
//  重载函数
//默认参数
//继承虚函数
//  继承虚函数
//  继承纯虚函数
//RTTI: 类的虚表_ZTV6ClassA，有一个地址_ZTI6ClassA，里面IDA会解析出reference to parent's type name就是该类的父类
#include <stdio.h>

class Base {
public: 
    Base() {
        mBaseMember = 10;
    }
    void setBaseMember(int m) {
        mBaseMember = m;
    }
    virtual int getBaseMember() {
        return mBaseMember;
    }
    
    virtual int addMember(int m) = 0;

    int mBaseMember;
    
};

class ClassA : public Base {
public:  
    ClassA() {
        mBaseMember = 100;
    }
    void setBaseMember(int m) {
        mBaseMember = m * 2;
    }
    void setBaseMember(int m, int n) {
        mBaseMember += m * n;
    }
    virtual int getBaseMember0() {
        return mBaseMember + 10;
    }
    // virtual int getBaseMember() {
    //     return mBaseMember;
    // }
    virtual int getBaseMember2() {
        return mBaseMember + 20;
    }
    virtual int addMember(int m) {
        return mBaseMember + m;
    }
    // int getBaseMember(float m) {
    //     return mBaseMember;
    // }
    // int getBaseMember(int type = 1) {
    //     if (type == 1) {
    //         return mBaseMember + 1;
    //     }
    //     return mBaseMember;
    // }
    int mBaseMember;
};

class ClassB : public Base {
public:   
    virtual int addMember(int m) {
        return mBaseMember + m;
    }
};

void test_func(int m = 10) {

}   
void test_exception(int n) {

    try
    {
        if (n == 1) {
            throw (char)'a';
        }
    }
    catch(char e)
    {
        printf("catch char");
    }
    
}
int main(int argc, char const *argv[])
{
    ClassA classA;
    ClassA* lpclassA = &classA;
    ClassB classB;
    //classA.mBaseMember = 10;
    classA.setBaseMember(20);
    classA.setBaseMember(20, 10);
    //test_exception(1);
    return lpclassA->getBaseMember() + classB.addMember(20);
}
