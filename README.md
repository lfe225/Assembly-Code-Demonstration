# CSE202-Assembly
This project was completed as part of my coursework for CSE 202 Computer Organization and Architecture.

## Project Overview
This project demonstrates my ability to write, compile, and link assembly code using the X86-64 Instruction Set Architecture (ISA). It showcases my skills in low-level programming and my understanding of how assembly integrates with high-level languages like C.

## Features
- **Assembly Functions**: Developed a variety of functions in X86-64 assembly, each designed to perform specific tasks, including arithmetic operations, sorting algorithms, and linked list manipulation.
- **C Integration**: C program, provided by my instructor, Houria Oudghiri, that calls these assembly functions, illustrating effective interoperability between C and assembly code.
- **Debugging Techniques**: Utilized GDB (GNU Debugger) to analyze register values and stack frames, enhancing my understanding of program execution at the hardware level.

## Functions Implemented
1. **abs**: Returns the absolute value of an integer.
2. **mult7div8**: Multiplies a signed character by 7, divides by 8 using bitwise operations, and manages overflow.
3. **max**: Finds the maximum value among four short integers.
4. **area**: Calculates the area of a triangle using Heron's formula, including a recursive square root function.
5. **reverse**: Reverses the elements of an array of strings.
6. **sort**: Sorts an array of integers using the bubble sort algorithm.
7. **sum**: Computes the sum of values in a linked list.
8. **product**: Calculates the product of two float vectors and stores the result in a third vector.


### Testing
You can test the initial setup by running:
```bash
bash runTests.sh
