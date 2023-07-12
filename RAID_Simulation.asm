#This program simulate how RAID 5 works by storing an input string in 3 virtual disks
.data
    #Storing input string
    input: .space 100
    #Prompt
    prompt: .asciiz "Enter a string: "
    #Output
    Disk: .asciiz "     Disk 1               Disk 2               Disk 3     \n"
    Upperline: .asciiz "---------------------------------------------------------\n"
.text
read_string:
    li $v0, 4
    la $a0, prompt
    syscall
    li $v0, 8
    la $a0, input
    li $a1, 100
    syscall
check_mul_of_8:
#Check if the length of input string is a multiple of 8
    la $s0, input
    lb $t1, ($s0)
    