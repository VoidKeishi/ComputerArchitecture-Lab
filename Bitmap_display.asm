# This program read a bitmap image then display it in Bitmap Display in MARS v4.5
.eqv     MONITOR 0X10010000
.data 
filename: .asciiz "image.bmp"
fileheader: .space 54
error_msg: .asciiz "Error reading the file"
.text

open_file:
    li $v0, 13
    la $a0, filename
    li $a1, 0
    li $a2, 0
    syscall

#Save file desciprtor
move $s0, $v0

read_header:
	li $v0, 14		
    move $a0, $s0	
	syscall
	blt $v0, $zero, error




error:
    li $v0, 4
    la $a0, error_msg
    syscall
    li $v0, 10
    syscall
