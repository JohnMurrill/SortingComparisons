/*
* Parallel bitonic sort using CUDA.
* Compile with
* nvcc -arch=sm_11 bitonic_sort.cu
* Based on http://www.tools-of-computing.com/tc/CS/Sorts/bitonic_sort.htm
*/
 
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
 
/* Every thread gets exactly one value in the unsorted array. */
#define THREADS 512 // 2^9
#define BLOCKS 32768 // 2^15
#define NUM_VALS THREADS*BLOCKS
 
void print_elapsed(clock_t start, clock_t stop){
    double elapsed = ((double) (stop - start));// CLOCKS_PER_SEC;
    printf("Elapsed time: %.3fs\n", elapsed);
}
 
float random_float(){
    return (float)rand()/(float)RAND_MAX;
}
 
void array_print(float *arr, int length){
    int i;
    for (i = 0; i < length; ++i) {
    printf("%1.3f ", arr[i]);
}
printf("\n");
}
 
void array_fill(float *arr, int length){
    srand(time(NULL));
    int i;
    for (i = 0; i < length; ++i) {
        arr[i] = random_float();
    }
}
 
__global__ void bitonic_sort_step(float *dev_values, int j, int k){
    unsigned int i, ixj; /* Sorting partners: i and ixj */
    i = threadIdx.x + blockDim.x * blockIdx.x;
    ixj = i^j;
 
    /* The threads with the lowest ids sort the array. */
    if ((ixj)>i) {
        if ((i&k)==0) {
            /* Sort ascending */
            if (dev_values[i]>dev_values[ixj]) {
                /* exchange(i,ixj); */
                float temp = dev_values[i];
                dev_values[i] = dev_values[ixj];
                dev_values[ixj] = temp;
            }
        }
    if ((i&k)!=0) {
        /* Sort descending */
        if (dev_values[i]<dev_values[ixj]) {
            /* exchange(i,ixj); */
            float temp = dev_values[i];
            dev_values[i] = dev_values[ixj];
            dev_values[ixj] = temp;
        }
    }
}
}
 
/**
* Inplace bitonic sort using CUDA.
*/
void bitonic_sort(float *values, int numVals){
    float *dev_values;
    size_t size = numVals * sizeof(float);
 
    cudaMalloc((void**) &dev_values, size);
    cudaMemcpy(dev_values, values, size, cudaMemcpyHostToDevice);
 
    dim3 blocks(BLOCKS,1); /* Number of blocks */
    dim3 threads(THREADS,1); /* Number of threads */
 
    int j, k;
/* Major step */
    for (k = 2; k <= NUM_VALS; k <<= 1) {
/* Minor step */
        for (j=k>>1; j>0; j=j>>1) {
            bitonic_sort_step<<<blocks, threads>>>(dev_values, j, k);
        }
    }
    cudaMemcpy(values, dev_values, size, cudaMemcpyDeviceToHost);
    cudaFree(dev_values);
}
 
int main(void){
    clock_t start, stop;
 
    //Initialize a 1000 element array to be sorted
    float *values = (float*) malloc( 1000 * sizeof(float));
    array_fill(values, 1000);
 
    start = clock();
    bitonic_sort(values, 1000); /* Inplace */
    stop = clock();
 
    print_elapsed(start, stop);
    free(values);
	
    //Initialize a 10,000 element array to be sorted
    float *Secondvalues = (float*) malloc( 10000 * sizeof(float));
    array_fill(Secondvalues, 10000);
 
    start = clock();
    bitonic_sort(Secondvalues, 10000); /* Inplace */
    stop = clock();
 
    print_elapsed(start, stop);
    free(Secondvalues);

    //Initialize a 1,000,000 element array to be sorted
    float *Thirdvalues = (float*) malloc( 1000000 * sizeof(float));
    array_fill(Thirdvalues, 1000000);
 
    start = clock();
    bitonic_sort(Thirdvalues, 1000000); /* Inplace */
    stop = clock();
 
    print_elapsed(start, stop);
    free(Thirdvalues);

    //Initialize a 2^24 element array to be sorted
    float *fourthvalues = (float*) malloc( NUM_VALS * sizeof(float));
    array_fill(fourthvalues, NUM_VALS);
 
    start = clock();
    bitonic_sort(fourthvalues, NUM_VALS); /* Inplace */
    stop = clock();
 
    print_elapsed(start, stop);
    free(fourthvalues);
}
