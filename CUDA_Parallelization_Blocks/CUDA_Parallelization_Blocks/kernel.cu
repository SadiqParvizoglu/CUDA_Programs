#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>

__global__ void kernel()
{
	int tid = blockIdx.x;
	printf("Block number %d\n", tid);
}

int main(void)
{
	int* dev_a;
	cudaMalloc((void**)&dev_a, sizeof(int));
	kernel << <10, 1 >> > ();
	cudaFree(dev_a);
	return 0;
}