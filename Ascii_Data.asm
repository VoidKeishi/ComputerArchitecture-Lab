# This program is for seeing how ascii characters are represented in data section of MIPS
.data
    str: .space 255

.text
    la $s0, str
    li $s1, 0
    loop:
    sb $s1, ($s0)
    addi $s1, $s1, 1
    addi $s0, $s0, 1
    bne $s1, 255, loop
    li $v0, 10
    syscall