#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
const int ThreadCount=15;
const int BlockCount=10;

__global__ void kernel()
{
    int tid_block = blockIdx.x;
    int tid_thread = threadIdx.x;
    printf("Block number %d. Thread number %d\n",tid_block, tid_thread);
}
int main(void)
{
	int* dev_a;
	cudaMalloc((void**)&dev_a, sizeof(int));
	kernel << <BlockCount, ThreadCount>> > ();
	cudaFree(dev_a);
	return 0;
}