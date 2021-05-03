#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <limits.h>

long jiffy(long start) {
    long k = 0;
    while ((long) time(NULL) == start) k++;
    return k;
}

float average(long measures[]) {
   double sum = 0;
   for (int k=0; k<4; k++) {
       sum += measures[k];
   }
   return (sum / 4.0);
}
  
int main(void)
{
	long measures[4];

	long min = LONG_MAX; 
	int k=0;
	int kmax=4;
	long start = (long) time(NULL);
	jiffy(start); // calibrate
	while (k < kmax) {
	        start = (long) time(NULL);
		measures[k] = jiffy(start);
		k++;
	}

	float result =  average(measures) / 500;
	printf("ok - %.2f BogoMIPS\n", result);
}

