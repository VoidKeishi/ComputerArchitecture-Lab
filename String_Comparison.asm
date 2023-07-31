# This program read 2 strings from user and print out whether they are equal or not
.data
    str1: .space 100
    str2: .space 100
    prompt1: .asciiz "Enter the 1st string: "
    prompt2: .asciiz "Enter the 2nd string: "
    prompt3: .asciiz "The strings are equal"
    prompt4: .asciiz "The strings are not equal"
.text
read:
    # Read string 1
    li $v0, 4
    la $a0, prompt1
    syscall
    li $v0, 8
    la $a0, str1
    li $a1, 100
    syscall
    # Read string 2
    li $v0, 4
    la $a0, prompt2
    syscall
    li $v0, 8
    la $a0, str2
    li $a1, 100
    syscall
    # Load string addresses
    la $t0, str1
    la $t1, str2
comparing:
    lb $t2, ($t0)
    lb $t3, ($t1)
    beq $t2, $zero, check_end
    bne $t2, $t3, not_equal
    addi $t0, $t0, 1
    addi $t1, $t1, 1
    j comparing
check_end:
    beq $t3, $zero, equal
not_equal: 
    li $v0, 4
    la $a0, prompt4
    syscall
    li $v0, 10
    syscall
equal:
    li $v0, 4
    la $a0, prompt3
    syscall
    li $v0, 10
    syscall