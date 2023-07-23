# Convert code below to asm code
#if (i<=j):
    #x=x+1;
    #z=1;
#else:
    #y=y-1;
    #z=2*z;

.text
init:
    li $s0, 1
    li $s1, 2
    li $s2, 3
    li $s3, 4
    # i store in $s0, j store in $s1, x store in $s2, y store in $s3, z store in $s4
    # i<=j
    slt $t0, $s0, $s1
    beq $t0, 1, if
    beq $s0, $s1, if
    j else
if:
    addi $s2, $s2, 1
    li $s4, 1
    j end
else:
    addi $s3, $s3, -1
    sll $s4, $s4, 1
end:


