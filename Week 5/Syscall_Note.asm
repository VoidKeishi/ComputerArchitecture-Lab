# This file store syscall syntax
.data
    str: .asciiz "Hello World\n"
.text
# Basic I/O syntax

    # Print decimal integer values
    li $v0, 1
    li $a0, 5 # 5 is the value to print
    syscall

    # Print string
    li $v0, 4
    la $a0, str # str is the string to print
    syscall

    # Read integer
    li $v0, 5
    syscall # $v0 contains the integer read

    # Read string
    li $v0, 8
    la $a0, str # str is the string to read
    li $a1, 10 # 10 is the maximum number of characters to read
    syscall # $v0 contains the string read

    # Print character
    li $v0, 11
    li $a0, 'a' # 'a' is the character to print
    syscall

    # Read character
    li $v0, 12
    syscall # $v0 contains the character read

# File

    # Open file
    li $v0, 13
    la $a0, str # str is the file name
    li $a1, 0 # 0 is the flag
    li $a2, 0 # 0 is the mode
    syscall # $v0 contains the file descriptor

    # Read file
    li $v0, 14
    li $a0, 1 # 1 is the file descriptor
    la $a1, str # str is the buffer
    li $a2, 10 # 10 is the number of bytes to read
    syscall # $v0 contains the number of bytes read

    # Write file
    li $v0, 15
    li $a0, 1 # 1 is the file descriptor
    la $a1, str # str is the buffer
    li $a2, 10 # 10 is the number of bytes to write
    syscall # $v0 contains the number of bytes written

    # Close file
    li $v0, 16
    li $a0, 1 # 1 is the file descriptor
    syscall

    # Exit
    li $v0, 10
    syscall