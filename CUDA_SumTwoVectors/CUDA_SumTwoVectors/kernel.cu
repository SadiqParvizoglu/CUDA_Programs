#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
const int N = 10;

__global__ void sumTwoVectors(int* a, int* b, int* c)
{
	int tid = blockIdx.x;
	if (tid < N)
	{
		c[tid] = a[tid] + b[tid];
		printf("Blok nömrəsi %d write %d massiv %d mövqe\n", tid, c[tid], tid);
	}
}

int main()
{
	int host_a[N], host_b[N], host_c[N];
	int* dev_a, * dev_b, * dev_c;
	cudaMalloc((void**)&dev_a, N * sizeof(int));
	cudaMalloc((void**)&dev_b, N * sizeof(int));
	cudaMalloc((void**)&dev_c, N * sizeof(int));
	for (int i = 0; i < N; i++)
	{
		host_a[i] = rand()%100;
		host_b[i] = rand()%100;
	}
	cudaMemcpy(dev_a, host_a, N * sizeof(int), cudaMemcpyHostToDevice);
	cudaMemcpy(dev_b, host_b, N * sizeof(int), cudaMemcpyHostToDevice);
	sumTwoVectors << <N, 1 >> > (dev_a, dev_b, dev_c);
	cudaMemcpy(host_c, dev_c, N * sizeof(int), cudaMemcpyDeviceToHost);
	for (int i = 0; i < N; i++)
		printf("%d + %d = %d\n", host_a[i], host_b[i], host_c[i]);
	cudaFree(dev_a);
	cudaFree(dev_b);
	cudaFree(dev_c);
	return 0;
}