#include <stdio.h>

struct func
{
    int n1;
    int n2;
    int n3;
    char* lpstr;
};

int func_ret_int() {
    struct func f = {0};
    f.n1 = 1;
    f.n2 = 2;
    f.n3 = 3;
    f.lpstr = "123";

    return f.n3;
}

struct func func_ret_struct() {
    struct func f = {0};
    f.n1 = 1;
    f.n2 = 2;
    f.n3 = 3;
    f.lpstr = "123";
    return f;
}

int main() {
    func_ret_struct();

    func_ret_int();

    struct func f = {0};
    f.n1 = 1;
    f.n2 = 2;
    f.n3 = 3;

    struct func* lp_f = &f;
    lp_f->n1 = 4;
    lp_f->n2 = 5;
}