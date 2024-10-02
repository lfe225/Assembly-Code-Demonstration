.global sort
# int* (8 bytes)list in %rdi
# int (4 bytes) n in %esi
sort:
  # Comparison, 4 bytes 
  cmpl	$1, %esi # %esi - 1
  # Jump if %esi <= 1
  jle	.L1 # While( i >= n || sorted )
  # Stack Push
  pushq	%rbp
  # Load effective addres, 4 bytes
  leal	-1(%rsi), %r11d # %r11d = %rsi - 1
  # Move, 4 bytes 
  movl	%esi, %ebp # %ebp = %esi
  # Exlusive Or, 4 bytes
  xorl	%eax, %eax # %eax = %eax ^ %eax
  # Stack Push
  pushq	%rbx
  # Move, 4 bytes
  movl	$1, %esi # %esi = 1
  # Move, 4 bytes
  movl	$1, %ebx # %ebx = 1
  # Exlusive Or
  xorl	%edx, %edx # %edx = %edx ^ %edx
# while(i < n && !sorted)
.L2: 
  # Addition, 4 bytes
  addl	$1, %eax # %eax = %eax + 1 => j++
  leaq	(%rdi,%rdx,4), %r9 #
  # Moves, 4 bytes to 8 bytes
  movslq	%eax, %rdx # %rdx = %eax
  # Move, 4 bytes
  movl	(%r9), %r8d
  leaq	(%rdi,%rdx,4), %rcx
  # Move, 4 bytes
  movl	(%rcx), %r10d # 
  # Comparison, 4 bytes
  cmpl	%r10d, %r8d # MRO = %r8d - %r10d 
  # Jump if %r8d < %r10d
  jle	.L4 #  while(j >= n-i){
  # Inside while loop
  # Move, 4 bytes
  movl	%r10d, (%r9) # Register to memory
  # Exclusive Or
  xorl	%esi, %esi # %esi 
  # Move, 4 bytes
  movl	%r8d, (%rcx)
.L4:
  # Comparison, 4 bytes
  cmpl	%r11d, %eax
  # While (j >= n-i)
  jl	.L2 # exits the inner while loop, goes to the outer loop
  # Addition, 4 bytes
  addl	$1, %ebx #i++
  # Test, 4 bytes 
  testl	%esi, %esi
  jne	.L3
  cmpl	%ebx, %ebp
  jle	.L3
  # Move, 4 bytes
  movl	%ebp, %r11d
  # Subtraction, 4 bytes
  subl	%ebx, %r11d
  # Test, 4 bytes 
  testl	%r11d, %r11d
  jle	.L3
  xorl	%eax, %eax
  # Move, 4 bytes 
  movl	$1, %esi
  xorl	%edx, %edx
  # while(i < n && !sorted)
  jmp	.L2 # End of the outer while loop, Goes back to the top
.L3:
  # Popping off stack
  popq	%rbx
  # Popping off stack
  popq	%rbp
  ret
# Return Statement
.L1:
  ret # return void


# void sort(int *list, int n){
#    int sorted=0, i=1, j;
#    int temp;
#    while(i < n && !sorted){
#         j=0;
#         sorted = 1;
#         while(j<n-i){
#             if(list[j] > list[j+1]){
#                 temp = list[j];
#                 list[j] = list[j+1];
#                 list[j+1] = temp;
#                 sorted = 0;
#             }
#             j++;
#         }
#         i++;
#     }
# }

    
