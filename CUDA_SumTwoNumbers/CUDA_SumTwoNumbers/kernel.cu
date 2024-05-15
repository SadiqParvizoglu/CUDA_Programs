
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>

__global__ void sumTwoNumbers(int a,int b,int *c)
{
    *c = a + b;
}

int main()
{
    int host_c;
    int* dev_c;
    cudaMalloc((void**)&dev_c, sizeof(int));
    sumTwoNumbers << <1, 1 >> > (17, 24, dev_c);
    cudaMemcpy(&host_c, dev_c, sizeof(int),cudaMemcpyDeviceToHost);
    printf("17 + 24 = %d\n", host_c);
    cudaFree(dev_c);
    return 0;
}