//
// direct_addressing.c
//

#include <stdio.h>
#include <stdlib.h>
// #include <bcm2835.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>
#include <unistd.h> 

typedef unsigned int uint32_t;

int main(int argc, char** argv) {
    // Load the memory addresses into this process address space
    // as a memory-mapped 'file'
    int memfd = open("/dev/mem", O_RDWR | O_SYNC);
    uint32_t * map = (uint32_t *)mmap(
                                    NULL,
                                    1024 * 4,
                                    (PROT_READ | PROT_WRITE),
                                    MAP_SHARED,
                                    memfd,
                                    0x3f200000);
    if (map == MAP_FAILED) {
        printf("bcm2835_init - mmap failed: %s\n", strerror(errno));
    }
    close(memfd);

    printf("Setting up pointers.\n");
    // Set output type
    volatile uint32_t* paddr = map;
    *paddr = 0x1000; 
    printf("Base pointer: %p\n", paddr);
    
    // Switch from high to low as fast as possible
    volatile uint32_t* paddr1 = map + 0x1C/4;
    printf("Set register %p.\n", paddr1);

    volatile uint32_t* paddr2 = map + 0x28/4;
    printf("Clear register %p.\n", paddr2);
    uint32_t mask = 0x10;
    for (int i = 0; i < 5; i++)
    {
        printf("High %p  \n", paddr1);
        *paddr1 = mask; // Set
        usleep(500000);
        printf("Low %p.\n", paddr2);
        *paddr2 = mask; // Clear
        usleep(500000);
    }
}
