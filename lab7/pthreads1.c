/* Example of using pthreads 
   Estimate pi by doubling the area under a unit semicircle
   Optional command-line argument - number of threads
   Adapted from EAPF Exemplars
   To compile:  gcc -o pthreads pthreads.c -lpthread -lm 
   Parallel design patterns:  data parallel;  loop parallel;  fork-join;  
     mutual exclusion  */

#include <stdio.h> 
#include <math.h> 
#include <pthread.h> 
#include <stdlib.h>

#define NUM_RECT 10000000 
#define DEFAULT_NUMTHREADS 1
long numthreads = DEFAULT_NUMTHREADS; 

double gPi = 0.0; // global accumulator for areas computed 
pthread_mutex_t gLock;


void *Area(void *pArg){
  int myNum = *((int *)pArg);
  int i;
  double h = 2.0 / NUM_RECT;
  double partialSum = 0.0, x; // local to each thread
  // use every numthreads-th step

  for (i = myNum; i < NUM_RECT; i += numthreads){
    x = -1 + (i + 0.5f) * h; 
    partialSum += sqrt(1.0 - x*x) * h;
  } 

  pthread_mutex_lock(&gLock);
  gPi += partialSum; // add partial to global final answer 
  pthread_mutex_unlock(&gLock); 
  return 0;
} 

int main(int argc, char **argv) {
  char *end = NULL;  /* receives address of first char after an int literal */
  if (argc > 1) {
    numthreads = strtol(argv[1], &end, 10); 
    if (numthreads == 0) {
      printf("invalid or zero int argument; using default thread count %d\n",
	     DEFAULT_NUMTHREADS);
      numthreads = DEFAULT_NUMTHREADS;
    }
  }
  printf("Using %d threads\n", numthreads);

  pthread_t tHandles[numthreads]; 
  int tData[numthreads], i; 

  pthread_mutex_init(&gLock, NULL);
  for (i = 0; i < numthreads; ++i ) {
    tData[i] = i; 
    pthread_create(&tHandles[i],       // Returned thread handle 
		   NULL,               // Thread Attributes
		   Area,               // Thread function 
		   (void*)&tData[i]);    // Data for Area()
  } 

  for ( i = 0; i < numthreads; ++i ) {
    pthread_join(tHandles[i], NULL);
  } 

  gPi *= 2.0;
  printf("Computed value of Pi: %12.9f\n", gPi ); 
  pthread_mutex_destroy(&gLock); 
  return 0;
}
