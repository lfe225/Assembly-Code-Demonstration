.global product
# float* (8 bytes) a in %rdi
# float* (8 bytes) b in %rsi
# float* (8 bytes) c in %rdx
# unsigned (4 bytes) size in %ecx
product:
  # Test, 4 bytes
  testl	%ecx, %ecx  # Most recent operation (MRO) = %ecx & %ecx = size & size
  # Error: Jump if MRO equal to zero
  je	.L1
  # Exclusive Or, 4 bytes
  xorl	%eax, %eax  # %eax = %eax ^ %eax = i ^ i
# Label: For Loop
.L2:
  # Double to quad word, 4 bytes to 8 bytes
  movslq	%eax, %r8 # %r8 = %eax => %r8 = i
  # Add, 4 bytes
  addl	$1, %eax # %eax = %eax + 1 => i = i + 1
  
  # Citation: Pizzia post 141
  # Citation: https://www.felixcloutier.com/x86/movss#:~:text=This%20instruction%20can%20be%20used,doublewords%20of%20two%20XMM%20registers.
  # Citation: https://mudongliang.github.io/x86/html/file_module_x86_id_214.html#:~:text=value%20in%20xmm1.-,Description,result%20in%20the%20destination%20operand. 
  # Move Single Precision Float, 4 bytes
  movss	(%rdi,%r8,4), %xmm0 # %xmm0 = %rdi + (4)(%r8) => c[i] = a[i]
  mulss	(%rsi,%r8,4), %xmm0 # %xmm0 *= %rsi + (4)(%r8) => c[i] = a[i] * b[i]
  movss	%xmm0, (%rdx,%r8,4) # Register to Memory => *(%rdx + (4)(%r8)) = *xmm0 
                                                                     # = pointer to the multiplication result 
                                      
  # Comparison, 4 bytes
  cmpl	%ecx, %eax  # MRO = %eax - %ecx => i - n
  # Jump if MRO not equal to zero 
  jne	.L2 # Jump if i < n
# Label: waits for the for loop to complete
.L1:
  ret #return %eax => the PRODUCT

# Product of two vectors in C
# void product(float *a, float *b, float *c, unsigned size){
#    for(int i=0; i<size; i++){
#        c[i] = a[i] * b[i];
#    }
# }
