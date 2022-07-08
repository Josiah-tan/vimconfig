#include"template.h"
#include<stdio.h>
#include<stdlib.h>
#include<limits.h>


int compare (const void *item1, const void *item2){
	int a = *((int*)item1);
	int b = *((int*)item2);
	if (a > b) return 1;
	if (b > a) return -1;
	return 0;
}

int main(void){
	// helloWorld();
	int T, N;
	scanf("%d", &T);
	for (int t = 0; t < T; t++){
		scanf("%d", &N);
		int* v = malloc(sizeof(int) * N);
		for (int i = 0; i < N; i++){
			scanf("%d", &v[i]);
		}
		qsort(v, N, sizeof(int), compare);
		for (int i = 0; i < N; i++){
			printf("%d ", v[i]);
		}
		printf("\n");
		free(v);
	}
	return 0;
}

