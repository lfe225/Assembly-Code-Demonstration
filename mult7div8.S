.global mult7div8
# char (1 byte) a in $dil
# char* (8 bytes) overflow in %rsi
mult7div8:
  # Load Address, 4 bytes
  leal	0(,%rdi,8), %edx # %edx = %rdi * (8 - 2^0) => char mult = (7 * a)

   # if(a < 0 && mult > 0)
  # Subtract, 4 bytes
  subl	%edi, %edx # %edx = %edx - %edi => mult - a
  # Test, 1 byte
  testb	%dil, %dil # MRO = %dil & %dil => a & a
  # Jump if a < 0 and mult > 0
  jle	.L1

  # if(a > 0 && mult < 0)
  # Move, 4 bytes
  movl	$1, %eax # %eax = 1 
  # Test, 1 byte
  testb	%dl, %dl # %dl & %dl => mult & mult
  # Jump if a >= 0 and mult >= 0
  jns	.L1

  # Else, overflow = 0
  # return mult / 8
  # Test, 1 byte
  testb	%dl, %dl # %dl & %dl => mult & mult
  # Move, 1 byte
  movb	%al, (%rsi) # Register to Memory 
  # Load Address, 4 bytes 
  leal	7(%rdx), %eax # %eax = %rdx + 7
  # Move if non negative
  cmovns	%edx, %eax 
  # Arithmetic right shift
  sarb	$3, %al # %al = %al >> 3 => mult / 8
  ret

# overflow = 1
# return mult/8
.L1:
  # Logical shift right, 1 byte
  shrb	$7, %dil # %dil = %dil >> 7
  # Test, 1 byte
  testb	%dl, %dl # %dl & %dl 
  # Setting greater flag 
  setg	%al
  # And, 4 bytes
  andl	%edi, %eax # %eax = %eax & %edi 
  testb	%dl, %dl
  movb	%al, (%rsi)
  leal	7(%rdx), %eax
  # Move if non negative
  cmovns	%edx, %eax
  # Arithmetic right shift
  sarb	$3, %al # %al = %al >> 3 => mult / 8
  ret

# char mult7div8(char a, char *overflow){
#     char mult = (7 * a);
#     if(a > 0 && mult < 0 || a < 0 && mult > 0)
#       overflow = 1;
#     else
#       overflow = 0;
#     return mult/8;
# }

    