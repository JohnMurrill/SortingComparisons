#include <iostream>
#include <time.h>
#include <cstdlib>
using namespace std;

const int INPUT_SIZE = 10000;

// A simple print function
void print(int *input)
{
    for ( int i = 0; i < INPUT_SIZE; i++ )
        cout << input[i] << " ";
    cout << endl;
}

// The partition function
int partition(int* input, int p, int r)
{
    int pivot = input[r];

    while ( p < r )
    {
        while ( input[p] < pivot )
            p++;

        while ( input[r] > pivot )
            r--;

        if ( input[p] == input[r] )
            p++;
        else if ( p < r )
        {
            int tmp = input[p];
            input[p] = input[r];
            input[r] = tmp;
        }
    }

    return r;
}

// The quicksort recursive function
void quicksort(int* input, int p, int r)
{
    if ( p < r )
    {
        int j = partition(input, p, r);        
        quicksort(input, p, j-1);
        quicksort(input, j+1, r);
    }
}

void array_fill(int *arr, int length){
    srand(time(NULL));
    int i;
    for (i = 0; i < length; ++i) {
        arr[i] = rand();
    }
}
void print_elapsed(clock_t start, clock_t stop){
    double elapsed_secs = ((double) (stop - start)) / CLOCKS_PER_SEC;
    cout << "Elapsed Time: ";
    cout << elapsed_secs;
    cout << "\n";
}

int main()
{
    clock_t start, stop;
    //Initialize a 1000 element random array to be sorted
    int *values = (int*) malloc( (1000) * sizeof(int));
    array_fill(values, 1000);

    start = clock();
    quicksort(values, 0, 1000);
    stop = clock();
    print_elapsed(start, stop);
    free(values);

    //Initialize a 10,000 random element array to be sorted
    int *SecondValues = (int*) malloc( (10000) * sizeof(int));
    array_fill(SecondValues, 10000);

    start = clock();
    quicksort(SecondValues, 0, 10000);
    stop = clock();
    print_elapsed(start, stop);
    free(SecondValues);

    //Initialize a 1,000,000 element array to be sorted
    int *ThirdValues = (int*) malloc( (1000000) * sizeof(int));
    array_fill(ThirdValues, 1000000);

    start = clock();
    quicksort(ThirdValues, 0, 1000000);
    stop = clock();
    print_elapsed(start, stop);
    free(ThirdValues);

    //Initialize an array with 2^24 elements to be sorted
    int *MaxValues = (int*) malloc( (512*32768) * sizeof(int));
    array_fill(MaxValues, (512*32768));

    start = clock();
    quicksort(MaxValues, 0, 512*32768);
    stop = clock();
    print_elapsed(start, stop);
    free(MaxValues);
    return 0;
}
