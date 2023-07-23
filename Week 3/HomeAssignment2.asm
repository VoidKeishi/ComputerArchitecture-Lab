# loop: 
    # i=i+step;
    # Sum=sum+A[i];
    # If(I !=n) goto loop;
.data
array: .byte 1,2,3,4,5,6,7,8,9,10
.text
init:
    # $t0 = i
    li $t0, 0
    # $t1 = sum
    li $t1, 0
    # $t2 = step
    li $t2, 1
    # $t3 = n
    li $t3, 10
    # $t4 = Array's address
    la $t4, array
loop:
    # i = i + step
    add $t0, $t0, $t2
    # sum = sum + A[i]
    lb $s0, 0($t4)
    add $t1, $t1, $s0
    # if (i != n) goto loop
    add $t4, $t4, $t2
    bne $t0, $t3, loop
    # print sum
    li $v0, 1
    move $a0, $t1
    syscall
    # exit
    li $v0, 10
    syscall
    


