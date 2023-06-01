.eqv SEVENSEG_LEFT 0xFFFF0011    # Dia chi cua den led 7 doan trai. 
                              # Bit 0 = doan a;     
                              # Bit 1 = doan b; ... 
                              # Bit 7 = dau . 
.eqv SEVENSEG_RIGHT 0xFFFF0010 # Dia chi cua den led 7 doan phai 
.data
ones: .byte 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F

.text   

main:
    la $t0, ones + 0($s0)
    lb $a0, 0($t0) # set value for segments  
    jal SHOW_7SEG_LEFT # show 
    nop 
    #Delay 1s
    jal begin_loop
    nop
    
    li $t3,9
    sub $s1,$t3,$s0
    la $t1, ones + 0($s1)
    lb $a0, 0($t1)  # set value for segments 
    jal SHOW_7SEG_RIGHT # show 
    nop 
    
    bgt $s0,9,exit
    #Delay 1s
    jal begin_loop
    nop
   
    addi $s0,$s0,1 
    j main
exit: 
    li $v0, 10 
    syscall 
endmain: 
#--------------------------------------------------------------- 
# Function SHOW_7SEG_LEFT : turn on/off the 7seg 
# param[in] $a0 value to shown 
# remark $t0 changed 
#--------------------------------------------------------------- 
SHOW_7SEG_LEFT: 
    li $t0, SEVENSEG_LEFT # assign port's address 
    sb $a0, 0($t0) # assign new value 
    nop 
    jr $ra 
    nop 
#--------------------------------------------------------------- 
# Function SHOW_7SEG_RIGHT : turn on/off the 7seg 
# param[in] $a0 value to shown 
# remark $t0 changed 
#--------------------------------------------------------------- 
SHOW_7SEG_RIGHT: li $t0, SEVENSEG_RIGHT # assign port's address 
    sb $a0, 0($t0) # assign new value 
    nop 
    jr $ra 
    nop
 #Delay 1s
begin_loop:
    li $t0, 25000   # Calculate the number of iterations for 1 second delay
loop:
    addi $t0, $t0, -1   # Decrement the loop counter
    bnez $t0, loop     # Branch back to loop if the counter is not zero
    jr $ra