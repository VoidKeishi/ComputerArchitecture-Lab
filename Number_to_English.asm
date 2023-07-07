# This program read a number from user and print it in words
.data
	number:     	 	 .space	12		#store input number
	millions_part:	  	 .space	4		#store 3 digit at million part
	thousands_part:	 .space	4		#store 3 digit at thousand part
	ones_part:		 .space	4		#store 3 digit at "one" part (<1000)
	temp:			 .space	4		#store 3 digit need processing temporary
	temp2:			 .space	4		#store the "tens" and the "ones" part of 3 digit
	prompt:      .asciiz		"Enter a number (0-999999999): "
	prompt2:    .asciiz		"Please enter number in range (0-999999999): "
	prompt3:	   .asciiz		"Do you want to continue?(Yes/No): "
	newline:	   .asciiz		"\n"   		# Newline character
	userInput:   .space	100    			# Buffer to store user input
        Yes: 	   .asciiz 		"Yes"  	# "Yes" string to compare with user input
	space:	  .asciiz		" "
	#For printing zero
	zero:		  
	.asciiz	"zero"
	# The following section defines strings for printing numbers from 1 to 19.
	# Each number is allocated 16 bytes of space to ensure consistent formatting.
	ones:
	.asciiz	"one"		
	.space	12
	.asciiz	"two"		
	.space	12
	.asciiz	"three"		
	.space	10
	.asciiz	"four"		
	.space	11
	.asciiz	"five"		
	.space	11
	.asciiz	"six"			
	.space	12
	.asciiz	"seven"		
	.space	10	
	.asciiz	"eight"		
	.space	10
	.asciiz	"nine"		
	.space	11	  
	.asciiz	"ten"			
	.space	12
	.asciiz	"eleven"		
	.space	9
	.asciiz	"twelve"		
	.space	9
	.asciiz	"thirteen"		
	.space	7
	.asciiz	"fourteen"		
	.space	7
	.asciiz	"fifteen"		
	.space	8
	.asciiz	"sixteen"		
	.space	8
	.asciiz	"seventeen"	
	.space	6
	.asciiz	"eighteen"	
	.space	7
	.asciiz	"nineteen"	
	.space	7
	# The following section defines strings for printing numbers from 20 to 90.
	# Each number is allocated 16 bytes of space to ensure consistent formatting.
	tens:		 
	.asciiz	"twenty"		
	.space	9	
	.asciiz	"thirty"		
	.space	9
	.asciiz	"forty"		
	.space	10
	.asciiz	"fifty"		
	.space	10
	.asciiz	"sixty"		
	.space	10
	.asciiz	"seventy"		
	.space	8
	.asciiz	"eighty"		
	.space	9
	.asciiz	"ninety"		
	.space	9
	#For printing hundred, thousand, million
	hundred:    .asciiz	"hundred"
	thousand:	  .asciiz	"thousand"
	million:	  .asciiz	"million"
 .text
message:
	# Clear memory
	li	$s0, 0
	sw	$s0, millions_part
	sw	$s0, thousands_part
	sw	$s0,	ones_part	
 	# Prompt the user to enter a number
 	li      $v0, 4
	la     $a0, prompt
	syscall
	
read:
	# Read the input number
	li      $v0, 5
	syscall
	sw   $v0, number
	bltz  $v0, error
	bgt	$v0,999999999,error
	j seperate
	
error:
	# If the number is negative, prompt the user to re enter another number
	li      $v0, 4
	la     $a0, prompt2
	syscall
	j read
	
seperate:
	#Divide the input number into 3 part (each part could be 0)
	la	$t0, number
	lw	$t1, ($t0)      
	beq  $t1, $zero, print_zero
        # Extract the first 3 digits
        rem	$t3, $t1, 1000	# Store 3 digit in $t3		
        div	$t1, $t1, 1000  # Divide $t1 by 1000
	sw	$t3, ones_part
	blt	$t1, 1, processing_millions
        # Extract the next 3 digits
        rem	$t3, $t1, 1000	# Store 3 digit in $t3		
        div	$t1, $t1, 1000  # Divide $t1 by 1000
	sw	$t3, thousands_part
	blt	$t1, 1, processing_millions
        # Extract the last 3 digits
        rem	$t3, $t1, 1000	# Store 3 digit in $t3		
        div	$t1, $t1, 1000  # Divide $t1 by 1000
	sw	$t3, millions_part
	j	processing_millions
	
processing_millions:
	# Print million part, if there is no million part, go to print thousand part
	lw	$t0, millions_part
	blt	$t0, 1, processing_thousands
	sw	$t0, temp
	addi $sp, $sp, -4     		# Decrement the stack pointer by 4 bytes
	sw 	$ra, 0($sp)       	# Store the return address on the stack
	jal 	print_3_digit   # Print 3 digit of this part
	nop
	li	$v0, 4
	la	$a0, million    # Adding million
	syscall
	li	 $v0, 4
	la	 $a0, space
	syscall
	
processing_thousands:
	# Print million part, if there is no million part, go to print thousand part
	lw	$t0, thousands_part
	blt	$t0, 1, processing_ones
	sw	$t0, temp
	addi $sp, $sp, -4      		# Decrement the stack pointer by 4 bytes
	sw 	$ra, 0($sp)       	# Store the return address on the stack
	jal 	print_3_digit		# Print 3 digit of this part
	nop
	li	$v0, 4
	la	$a0, thousand # Adding thousand
	syscall
	li	 $v0, 4
	la	 $a0, space
	syscall
	
processing_ones:
	# Print million part then end
	lw	$t0, ones_part
	blt	$t0, 1, end
	sw	$t0, temp
	jal 	print_3_digit
	nop
	j end
	
print_3_digit:
	#Take the 3 digit
	lw	$t0, temp
	bltz	$t0, return
	#Take hundred digit
	div	$t1, $t0, 100
	#Take "tens" and "ones" digit
	rem	$t2, $t0, 100
	sw	$t2, temp2
	#Print hundred	
	addi $sp, $sp, -4     		# Decrement the stack pointer by 4 bytes
	sw 	$ra, 0($sp)     	# Store the return address on the stack
	jal 	print_hundred
	nop
	# If "tens" and "ones" digit less than 20
	jal 	print_one_to_nineteen
	nop
	lw 	$t2, temp2
	# If "tens" and "ones" digit less than 20
	jal 	print_twenty_to_ninetynine
	nop
	#Return to where it was called
	lw 	 $ra, 0($sp)        	# Load the return address from the stack
	addu $sp, $sp, 4   	        # Increment the stack pointer by 4 bytes
	jr $ra
	
print_hundred:
	blt	$t1, 1, return
	mul  $t1, $t1, 16
	li	$v0, 4
	la	$a0, ones + -16($t1) 	
	syscall
	li	 $v0, 4
	la	 $a0, space
	syscall
	li	 $v0, 4
	la	 $a0, hundred
	syscall
	li	 $v0, 4
	la	 $a0, space
	syscall
	j return 
	
print_one_to_nineteen:
	lw 	$t2, temp2
	bgt	$t2, 19, return
	blt	$t2, 1, return
	mul  $t2, $t2, 16
	li	$v0, 4
	la	$a0, ones + -16($t2)
	syscall
	li	 $v0, 4
	la	 $a0, space
	syscall
	j return
	
print_twenty_to_ninetynine:
	lw 	$t2, temp2
	blt	$t2, 20, return
	#Extract each digit
	div	$t3, $t2, 10
	rem  $t4, $t2, 10
	#Print tens
	mul  $t3, $t3, 16
	li	$v0, 4
	la	$a0, tens + -32($t3)
	syscall
	#Print space
	li	 $v0, 4
	la	 $a0, space
	syscall
	#Print ones
	blt	 $t4, 1, return
	mul   $t4, $t4, 16
	li	 $v0, 4
	la	 $a0, ones + -16($t4)
	syscall
	#Print space
	li	 $v0, 4
	la	 $a0, space
	syscall
	j return
	
return:				# Back to previous call
	jr 	 $ra        # Jump back to the return address
	
print_zero:
	li	$v0, 4
	la	$a0, zero
	syscall
	j end
	
end:
	#Prompt user to read again or exit
	# Print a newline
   	li $v0, 4         	# System call code for printing a string
   	la $a0, newline   	# Load the address of the newline string
 	syscall
	li $v0, 4
   	la $a0, prompt3
	syscall
	li $v0, 8 
	la $a0, userInput
	li $a1, 4 
	syscall
	# Print a newline
   	li $v0, 4         	# System call code for printing a string
   	la $a0, newline   	# Load the address of the newline string
 	syscall
	la $s0, userInput
   	la $s1, Yes

compare_loop:
    lb $t0, ($s0)      # Load a character from user input
    lb $t1, ($s1)      # Load a character from stored string

    # Compare characters
    bne $t0, $t1, exit

    # Characters are equal, check if the end of strings is reached
    beqz $t0, message    # If $t0 (or $t1) is zero, both strings have reached the end

    # Move to the next character
    addi $s0, $s0, 1
    addi $s1, $s1, 1
    j compare_loop
    
exit:
	# Exit the program
	li	 $v0, 10
	syscall
