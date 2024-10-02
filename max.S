.global max
# short (2 bytes) v1 in %di
# short (2 bytes) v2 in %si
# short (2 bytes) v3 in %dx, 
# short (2 bytes) v4 in %cx
max:
  # v1 MAX
  movl	%edi, %eax    #  %eax = %edi => %eax = v1

  #v3 MAX
  # Comparison, 2 bytes
  cmpw	%dx, %cx      #  Most recent operation (MRO) = %cx - %dx => v4 - v3
  # If Statement on MRO, Move 
  cmovl	%edx, %ecx    #   if( %cx < %dx ) => if( v4 < v3 )
                      #   { %ecx = %edx } => { %ecx = v3}

  #v2 MAX
  # Comparison, 2 bytes
  cmpw	%si, %cx      #  MRO = %cx - %si => v4 - v2
  # If Statement on MRO, Move
  cmovl	%esi, %ecx    #  if( %cx < %si )=> if( v4 < v2)
                      #   { %ecx = %esi } => { %ecx = v2} 

  #v4 MAX
  # Comparison, 2 bytes
  cmpw	%di, %cx      #  MRO = %cx - %di => v4 - v1 
  # If Statement on MRO, Move
  cmovge	%ecx, %eax  # if( %cx >= %di) => if (v4 >= v1)
                      #  { %eax = %ecx }  => { %eax = v4}
                      
  ret # Return %eax => the MAX

# short max(short v1, short v2, short v3, short v4){
#     if(v1 < v2)
#       v1 = v2;
#     if(v1 < v3)
#       v1 = v3;
#     if(v1 < v4)
#       v1 = v4;
#     return v1;
# }

