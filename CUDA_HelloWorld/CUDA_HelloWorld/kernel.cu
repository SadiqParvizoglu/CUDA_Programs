
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>

__global__ void HelloWorld()
{
    printf("Hello World, %d, %d\n",blockIdx.x,threadIdx.x);
}

int main()
{
    HelloWorld << <1, 1 >> > ();
    return 0;
}