.global sum
# struct ll *list (8 bytes) in %rdi
sum:
  # Exclusive Or
  xorl	%eax, %eax # %eax = %eax ^ %eax
  testq	%rdi, %rdi # Most Recent Operation (MRO) = %rdi & %rdi
  # Jump if MRO is zero
  je	.L1 # if(ptr == NULL)
# while (ptr)
.L2:
  # Addition, 8 bytes
  addq	8(%rdi), %rax # %rax = %rdi + 8 => total += ptr->value
  # Move, 8 bytes
  movq	16(%rdi), %rdi # %rdi = %rdi + 16 => ptr = ptr->next;
  # Test, 8 bytes
  testq	%rdi, %rdi # %rdi & %rdi => ptr ^ ptr
  # Jump if MRO is not equal to 0
  jne	.L2 # while(ptr)
  # Return Statement
  ret # %rax => total
# Bypass while statement
.L1:
  ret # %rax => total


# struct ll{
#    char *name; 
#    long value;
#    struct ll *next;
#};

# sum of the elements of a linkedlist in C
# long sum(struct ll *list){
#    long total = 0;
#    struct ll *ptr = list;
#    while(ptr){
#        total += ptr->value;
#        ptr = ptr->next;
#    }
#    return total;
# }
