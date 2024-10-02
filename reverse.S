.global reverse
# char** (8 bytes) list in %rdi
# unsigned (4 bytes) n in %esi
reverse:
  # Move, 4 bytes
  movl	%esi, %edx  # %edx = %esi => %edx = n
  # Subtract, 4 bytes
  subl	$1, %esi # %esi = %esi - 1 => %esi = n - 1
  # Move, 8 bytes
  movq	%rdi, %rax  # %rax = %rdi => %rax = list
  # Shift right, 4 bytes
  shrl	%edx # %edx = %edx >> 1 => n >> 1 -> n/2
  # Move, 4 bytes
  movl	%esi, %r9d # %r9d = %esi => %r9d = n -1 
  # Subtract, 4 bytes
  subl	%edx, %r9d # %r9d = %r9d - %edx => i - (n/2)
  # Test, 4 bytes
  testl	%edx, %edx # Most Recent Operation (MRO) = %edx & %edx => (n/2) & (n/2)
  # Jump if MRO equal to zero 
    je	.L1 #if( i = n/2 )
# Label: While Loop 
.L2:
  # Move, 4 bytes
  movl	%esi, %edx # %edx = %esi => %edx = n - 1
  # char *temp = list[i];
    # Move, 8 bytes
    movq	(%rax), %rcx # Memory to register => %rcx = *(%rax) => %rcx = *list
  # list[i] = list[n-i-1];
    # Subtract, 4 bytes
    subl	$1, %esi # %esi = %esi - 1 => %esi = n - 1 - 1
    addq	$8, %rax # %rax = %rax + 8 => %rax = list + 8
    leaq	(%rdi,%rdx,8), %rdx # Memory to Register => %rdx = *( %rdi + 8 * %rdx ) =>
    # Move, 8 bytes
    movq	(%rdx), %r8 # Memory to Register => %r8 = *( %rdx )
  # list[n-i-1] = temp;
    # Move, 8 bytes
    movq	%r8, -8(%rax) # Register to Memory => -8(%rax) = *(%r8) =>
    # Move, 8 bytes
    movq	%rcx, (%rdx) # Register to Memory => (%rdx) = *( %rcx )
    # Comparison, 4 bytes 
  cmpl	%esi, %r9d  # Most Recent Operartion (MRO) = %r9d - %esi = (n/2) - i
  # Jump if MRO equal to zero 
  jne	.L2 # Jump if i < n / 2
#Label: after recursive method completes
.L1:
  ret #return void

# void reverse(char **list, unsigned n){
#     unsigned i = 0;
#     while (i < n/2){
#      char *temp = list[i];
#      list[i] = list[n-i-1];
#      list[n-i-1] = temp;
#      i++;
#     }
# }

