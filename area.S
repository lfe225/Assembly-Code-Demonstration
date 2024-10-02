.global area
# int (4 bytes) x in %edi
r_sqrt:
  # Test, 4 bytes
  testl	%edi, %edi # Most Recent Opertaion (MRO) = %edi & %edi => x & x
  # Jump if MRO is negative 
  js	.L1 # if(x < 0)
  # Save %rbx
  pushq	%rbx
  # Move, 4 bytes
  movl	%edi, %eax # %eax = %edi => %eax = x
  # Move, 4 bytes
  movl	%edi, %ebx # %ebx = %edi => %ebx = x
  # Comparison, 4 bytes
  cmpl	$1, %edi # MRO = %edi - 1 => x - 1
  # Jump 
  jle	.L2 # if (x < 2)
  # Arithmetic right shift, 4 bytes
  sarl	$2, %eax # %eax = %eax >> 2 = x >> 2
  movl	%eax, %edi # %edi = %eax => %edi = x >> 2
  # Calling r_sqrt 
  call	r_sqrt@PLT # r_sqrt( x >> 2)
  # Addition, 4 bytes => Multiply by two
  addl	%eax, %eax # %eax = %eax + %eax => r_sqrt( x >> 2) << 1
  # Load effective Address, 4 bytes
  leal	1(%rax), %edx # %edx = %rax + 1 => %edx = small_cand + 1
  # Move, 4 bytes 
  movl	%edx, %ecx  # %ecx = %edx => large_cand = small_cand + 1
  # Multiply, 4 bytes
  imull	%edx, %ecx  # %ecx = %ecx * %edx => large_cand * large_cand
  # Comparison, 4 bytes
  cmpl	%ecx, %ebx # MRO = %ebx - %ecx => large_cand * large_cand - x
  # Move if large_cand * large_cand < x
  cmovge	%edx, %eax # %eax = %edx => %eax = large_cand
# Body: if( x < 2 )
.L2:
  popq	%rbx # { %rbx = x
  ret # return %eax => return x}
# Body: if( x < 0 )
.L1:
  movl	$-1, %eax # { %eax = -1
  ret # return %eax => return -1 }

# int (4 bytes) a in %edi
# int (4 bytes) b in $esi
# int (4 bytes) c in %edx
area:
  # Move, 4 bytes
  movl	%edi, %ecx # %ecx = %edi => %ecx = a
  # Load effective Address, 4 bytes
  leal	(%rsi,%rdx), %edi # %edi = %rsi + %rds => b + c
  # Addition, 4 bytes
  addl	%ecx, %edi # %edi = %edi + %ecx => %edi = a + b + c
  # Move, 4 bytes
  movl	%edi, %eax # %eax = %edi => %eax = a + b + c
  # Logical shift right, 4 bytes
  shrl	$31, %eax # %eax = %eax >> 31
  # Addition, 4 bytes
  addl	%edi, %eax # %eax = %eax + %edi 
  # Arithmetic shift right, 4 bytes
  sarl	%eax # %eax = %eax >> 1 => %eax = (a + b + c)/2
  # Move, 4 bytes
  movl	%eax, %edi # %edi = %eax => p = (a + b + c)/2
  # Subtraction, 4 bytes
  subl	%ecx, %edi # %edi = %edi - %ecx => p - a
  # Move, 4 bytes
  movl	%eax, %ecx # %ecx = %eax => %ecx = p
  # Subtraction, 4 bytes
  subl	%esi, %ecx  # %ecx = %ecx - %esi => p - b
  # Multiply, 4 bytes
  imull	%ecx, %edi # %edi = %edi * %ecx => (p-a) * (p-b)
  # Multiply, 4 bytes
  imull	%eax, %edi  # %edi = %edi * %eax => p * (p-a) * (p-b)
  # Subtract, 4 bytes 
  subl	%edx, %eax # %eax = %eax - %edx => %eax = p - c
  # Multiply, 4 bytes
  imull	%eax, %edi # %edi = %edi * %eax => p * (p-a) * (p-b) * (p-c)
  # Calling method r_sqrt(p)
  jmp	r_sqrt@PLT
 

# int area(int a, int b, int c){
#     int p = (a + b + c)/2;
#     p = p * (p-a) * (p-b) * (p-c);
#     return sqrt(p);
# }
# calculate recursively the square root of an int (in C) 
# int r_sqrt(int x){
#    if(x < 0)
#        return -1;
#    if (x < 2)
#        return x;
#   /* recursive call */
#    int small_cand = r_sqrt(x >> 2) << 1;
#    int large_cand = small_cand + 1;
#    if (large_cand * large_cand > x)
#        return small_cand;
#    else
#        return large_cand;
# }
