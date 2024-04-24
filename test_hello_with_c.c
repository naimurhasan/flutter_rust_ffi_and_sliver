#include<stdio.h>

void say_hello();

int main() {
    say_hello();
    return 0;
}

// gcc -o test_hello_with_c test_hello_with_c.c -L/Users/naimur/Devlopment/coding_round/task2/hello/target/release/ -lhello