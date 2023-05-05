.data
	A: .word 7, -2, 5, 1, 5, 6, 7, 3, 6, 8, 8, 59, 5
	Aend: .word 
.text
main: 	
	la $a0,A #$a0 = Address(A[0])
	la $a1,Aend
 	j sort #sort
sort: 	
	beq $a0,$a1,done #single element list is sorted
 	addi $v0,$a0,0 #init pointer to the first element
 	addi $a1,$a1,-4 #decrease last
loop:
 	beq $v0,$a1,sort #if done this loop (pointer=last) branch to sort
 	lw $s1,0($v0) #init value of the address
 	lw $s2,4($v0) #init next value
 	slt $t2,$s1,$s2 # this < next
 	bne $t2,$zero,swap
 	addi $v0,$v0,4
 	j loop
swap:
 	sw $1,4($v0)
 	sw $s2,0($v0)
 	addi $v0,$v0,4
 	j loop
done: 	
	li $v0, 10 #exit
 	syscall
