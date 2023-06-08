# Bài 1. Viết chương trình điều khiển MarsBot để vẽ 2 chữ cài đầu tiên của họ và tên sinh viên trên màn hình
# Chữ cần viết : P A
.eqv HEADING 0xffff8010 	# Integer: An angle between 0 and 359 
					 	# 0 : North (up) 
					 	# 90: East (right) 
					 	# 180: South (down) 
					 	# 270: West (left) 
.eqv MOVING 0xffff8050   	# Boolean: whether or not to move 
.eqv LEAVETRACK 0xffff8020  # Boolean (0 or non-0):
					        # whether or not to leave a track 
.eqv WHEREX 0xffff8030 	       # Integer: Current x-location of MarsBot 
.eqv WHEREY 0xffff8040 	       # Integer: Current y-location of MarsBot 
.text 
main: 
    jal UNTRACK 
    nop
    addi $a0, $zero, 135 
    jal ROTATE
    jal GO 
    nop
sleep0: 
    addi $v0,$zero,32  
    li $a0,1000
    syscall 
P1:
    addi $a0, $zero, 180 
    jal ROTATE
    jal TRACK 
    nop 
sleep1: 
    addi $v0,$zero,32 
    li $a0,2000
    syscall 
P2: 
    jal UNTRACK  
    nop
    addi $a0, $zero, 0  
    jal ROTATE
    jal GO 
    nop
sleep2: 
    addi $v0,$zero,32 
    li $a0,1300
    syscall 
P3:
    jal TRACK  
    nop
    addi $a0, $zero, 90 
    jal ROTATE
    jal GO 
    nop
sleep3: 
    addi $v0,$zero,32 
    li $a0,600
    syscall 
P4:
    jal UNTRACK 
    nop
    addi $a0, $zero, 55 
    jal ROTATE
    jal TRACK 
    nop
    jal GO 
    nop
sleep4: 
    addi $v0,$zero,32  
    li $a0,300
    syscall 
P5:
    jal UNTRACK 
    nop
    addi $a0, $zero, 0  
    jal ROTATE
    jal TRACK 
    nop
    jal GO 
    nop
sleep5: 
    addi $v0,$zero,32  
    li $a0,340
    syscall 
P6:
    jal UNTRACK  
    nop
    addi $a0, $zero, 315 
    jal ROTATE
    jal TRACK  
    nop
    jal GO 
    nop
sleep6:
    addi $v0,$zero,32 
    li $a0,300
    syscall 
P7:
    jal UNTRACK 
    nop
    addi $a0, $zero, 270  
    jal ROTATE
    jal TRACK 
    nop
    jal GO 
    nop
sleep7: 
    addi $v0,$zero,32 
    li $a0,650
    syscall
P8:
    jal UNTRACK  
    nop
    addi $a0, $zero, 90 
    jal ROTATE
    jal GO 
    nop
sleep8:
    addi $v0,$zero,32 
    li $a0,2000
    syscall 
P9:
    jal UNTRACK  
    nop
    addi $a0, $zero, 200 
    jal ROTATE
    jal TRACK 
    nop
    jal GO 
    nop
sleep9:
    addi $v0,$zero,32 
    li $a0,2200
    syscall 
P10:
    jal UNTRACK  
    nop
    addi $a0, $zero, 20  
    jal ROTATE
    jal TRACK 
    nop
    jal GO 
    nop
sleep10:
    addi $v0,$zero,32 
    li $a0,1000
    syscall 
P11:
    jal UNTRACK  
    nop
    addi $a0, $zero, 90  
    jal ROTATE
    jal TRACK 
    nop
    jal GO 
    nop
sleep11:
    addi $v0,$zero,32 
    li $a0,800
    syscall 
P12:
    jal UNTRACK  
    nop
    addi $a0, $zero, 160 
    jal ROTATE
    jal TRACK 
    nop
    jal GO 
    nop
sleep12:
    addi $v0,$zero,32  
    li $a0,1000
    syscall 
P13:
    jal UNTRACK  
    nop
    addi $a0, $zero, 340  
    jal ROTATE
    jal TRACK  
    nop
    jal GO 
    nop
sleep13:
    addi $v0,$zero,32  
    li $a0,2200
    syscall
P14:
    jal UNTRACK  
    nop
    addi $a0, $zero, 0  
    jal ROTATE
sleep14:
    addi $v0,$zero,32  
    li $a0,2000
    syscall
end_main:
    jal STOP
    nop
    li $v0, 10
    syscall
#----------------------------------------------------------- 
# GO procedure, to start running # param[in] none 
#----------------------------------------------------------- 
GO: 
    li $at, MOVING # change MOVING port 
    addi $k0, $zero,1 # to logic 1, 
    sb $k0, 0($at) # to start running 
    nop 
    jr $ra 
    nop 
#----------------------------------------------------------- 
# STOP procedure, to stop running # param[in] none 
#-----------------------------------------------------------
STOP: 
    li $at, MOVING # change MOVING port to 0 
    sb $zero, 0($at) # to stop 
    nop 
    jr $ra 
    nop 
#----------------------------------------------------------- 
# TRACK procedure, to start drawing line 
# param[in] none 
#----------------------------------------------------------- 
TRACK: 
    li $at, LEAVETRACK 
    # change LEAVETRACK port 
    addi $k0, $zero,1 # to logic 1, 
    sb $k0, 0($at) # to start tracking 
    nop 
    jr $ra 
    nop 
#----------------------------------------------------------- 
# UNTRACK procedure, to stop drawing line 
# param[in] none 
#----------------------------------------------------------- 
UNTRACK:
    li $at, LEAVETRACK 
    # change LEAVETRACK port to 0 
    sb $zero, 0($at) # to stop drawing tail 
    nop 
    jr $ra 
    nop 
#----------------------------------------------------------- 
# ROTATE procedure, to rotate the robot 
# param[in] $a0, An angle between 0 and 359 
# 0 : North (up) 
# 90: East (right) 
# 180: South (down) 
# 270: West (left) 
#----------------------------------------------------------- 
ROTATE: 
    li $at, HEADING # change HEADING port 
    sw $a0, 0($at) # to rotate robot 
    nop 
    jr $ra 
    nop