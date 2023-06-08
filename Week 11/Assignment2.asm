# Pham Phan Anh - 20210039
# 3 so cuoi ma sinh vien 039 --> Ma hoa sang ma Hex: 0x27

.eqv KEY_CODE   0xFFFF0004      # ASCII code from keyboard, 1 byte
.eqv KEY_READY  0xFFFF0000      # =1 if has a new keycode ?
				# Auto clear after lw
.eqv DISPLAY_CODE   0xFFFF000C  # ASCII code to show, 1 byte
.eqv DISPLAY_READY  0xFFFF0008  # =1 if the display has already to do
				# Auto clear after sw
				
.text
li   $k0,  KEY_CODE
li   $k1,  KEY_READY
li   $s0, DISPLAY_CODE
li   $s1, DISPLAY_READY
loop:        
nop
WaitForKey:  
lw   $t1, 0($k1)            # $t1 = [$k1] = KEY_READY
nop
beq  $t1, $zero, WaitForKey # if $t1 == 0 then Polling
nop
#----------------------------------------------------
ReadKey:     lw   $t0, 0($k0)            # $t0 = [$k0] = KEY_CODE
nop
#----------------------------------------------------
WaitForDis:  lw   $t2, 0($s1)            # $t2 = [$s1] = DISPLAY_READY
nop
beq  $t2, $zero, WaitForDis # if $t2 == 0 then Polling             
nop             
#----------------------------------------------------
Encrypt:     xori $t0, $t0, 0x00000027          # change input key
#----------------------------------------------------
ShowKey:     sw $t0, 0($s0)              # show key
nop               
#----------------------------------------------------
j loop
nop
