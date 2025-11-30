#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

#define ALLOC_PAGES 300
#define PGSIZE 4096

int main() {
    char *buf[ALLOC_PAGES];
    for(int i = 0; i < ALLOC_PAGES; i++){
        buf[i] = malloc(PGSIZE);
        if(buf[i] == 0){
            printf("malloc failed at %d\n", i);
            exit(1);
        }
        for(int j = 0; j < PGSIZE; j++)
            buf[i][j] = i;
    }

    printf("Memory allocated and initialized.\n");

    for(int i = ALLOC_PAGES-1; i >= 0; i--){
        int sum = 0;
        for(int j = 0; j < PGSIZE; j++)
            sum += buf[i][j];
        if(sum != i*PGSIZE){
            printf("Data mismatch at page %d\n", i);
        }
    }

    printf("Swap test finished successfully.\n");
    exit(0);
}
