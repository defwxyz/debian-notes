#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <limits.h>

void waitfornext() {
	long start = (long) time(NULL);
        while ((long) time(NULL) == start) ;
}

long jiffy() {
    long loops_per_jiffy = 1;
    while (1) {
	long start = (long) time(NULL);
	long k;
        for (k=0; k < loops_per_jiffy; k++) ;
	long stop = (long) time(NULL);
 	if (stop - start > 0) break;
	loops_per_jiffy++;	
    }
    return loops_per_jiffy;
}

int main(void)
{
	long min = LONG_MAX; 
	int k=0;
	int kmax=4;

	while (k < kmax) {
		waitfornext();
		long j = jiffy();
		if (j < min) 
			min = j;
		k++;
	}
	float result =  min / 500.0;
	printf("ok - %.2f BogoMIPS\n", result);
}

