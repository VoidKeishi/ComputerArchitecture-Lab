#This program simulate how RAID 5 works by storing an input string in 3 virtual disks
.data
    #Storing input string
    input: .space 100
    #Prompt
    prompt: .asciiz "Enter a string: "
    error_message: .asciiz "Error: The length of input string must be a multiple of 8\nPlease enter a new string: "
    valid: .asciiz "Valid input string\n"
    #Output
    Disk: .asciiz "     Disk 1               Disk 2               Disk 3     \n"
    Upperline: .asciiz "----------------------------------------------------------\n"
    first_half: .space 5
    second_half: .space 5
    xor_part1: .space 3
    xor_part2: .space 3
    xor_part3: .space 3
    xor_part4: .space 3
    comma: .asciiz ","
    frame_first_part_data: .asciiz "|     "
    frame_second_part_data: .asciiz "     |"
    space_between_column: .asciiz "     "
    frame_first_part_xor: .asciiz "[[ "
    frame_second_part_xor: .asciiz "]]"
.text
prompt_to_enter:
    li $v0, 4
    la $a0, prompt
    syscall
read:
    li $v0, 8
    la $a0, input
    li $a1, 100
    syscall
init_count:
    la $s0, input
    li $s1, 0
count:
    #Check if the length of input string is a multiple of 8
    lb $t1, ($s0)
    #Branch if encounter newline or null
    beq $t1, '\n', check_mul_of_8
    beqz $t1, check_mul_of_8
    #Else continue counting
    addi $s0, $s0, 1
    addi $s1, $s1, 1
    j count
check_mul_of_8:
    andi $s2, $s1, 7
    beqz $s2, init_disk
    j error
init_disk:
    li $v0, 4
    la $a0, valid
    syscall
    j exit
error:
    li $v0, 4
    la $a0, error_message
    syscall
    j read
exit:
    li $v0, 10
    syscall


    
    