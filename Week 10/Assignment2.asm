#Pham Phan Anh - 20210039

.eqv MONITOR_SCREEN 0x10010000   #Dia chi bat dau cua bo nho man hinh
.eqv WHITE          0x00FFFFFF
.eqv BLACK	    0x00000000

.text
initialize:
	li $k0, MONITOR_SCREEN      #Nap dia chi bat dau cua man hinh
	li $t0, WHITE
	li $t1, BLACK
	li $t2, 1

loop:
	bgt $t2,129,initialize   #For 32x32 square run in 256x512
	sw $t1, -4($k0)
	sw $t0, 0($k0)
	
	addi $k0, $k0, 4
	addi $t2, $t2, 1
	j loop