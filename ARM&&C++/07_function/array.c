#include <stdio.h>


char global_array[100] = {0};

int main(int argc, char const *argv[])
{
    int n_array[20] = {0};
    n_array[3] = 3;

    for (size_t i = 0; i < sizeof(n_array); i++)
    {
        n_array[i] = i + 3;
        *(n_array + i) = i + 6;
    }

    int* lp_array = n_array;
    for (size_t i = sizeof(n_array) - 1; i >= 0; i--)
    {
        *(lp_array - i) = i + 9;
    }
    
    static char static_array[100] = {0};

    for (size_t i = 0; i < sizeof(static_array); i++)
    {
       static_array[i] = i;
    }
    for (size_t i = 0; i < sizeof(global_array); i++)
    {
       global_array[i] = i;
    }
    
    return 0;
}