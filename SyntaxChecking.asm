# This program is to check if an assembly instruction is valid or not
.data
    #For stop
    stop: .asciiz "stop\n"    #If user want to exit
    #For storing instructions
    input: .space 100
    opcode_part: .space 10
    operand1: .space 10
    operand2: .space 10
    operand3: .space 70
    #For printing message
    prompt: .asciiz "Enter an assembly instruction(Type 'stop' if you want to exit): "
    opcode: .asciiz "Opcode '"
    operand: .asciiz "Operand '"
    valid: .asciiz "' is valid"
    invalid: .asciiz "' is invalid"
    clock_cycles: .asciiz "Number of clock cycles: "
    #For instruction patterns
    #"opcode","operand type","number of clock cycles"
    #x=nothing, r=register, i=immediate, l=label, s=special address, f=float register
    instructions: .asciiz 
    "abs.d","ffx","1",
    "abs.s","ffx","1",
    "add","rrr","1",
    "add.d","rrr","1",
    "add.s","rrr","1",
    "addi","rri","1",
    "addiu","rri","1",
    "addu","rrr","1",
    "and","rrr","1",
    "andi","rri","1",
    "bc1f","lxx","2",
    "bc1t","lxx","2",
    "beq","rrl","2",
    "bgez","rlx","2",
    "bgezal","rlx","2",
    "bgtz","rlx","2",
    "blez","rlx","2",
    "bltz","rlx","2",
    "bltzal","rlx","2",
    "bne","rrl","2",
    "break","xxx","2",
    "c.eq.d","ffx","2",
    "c.eq.s","ffx","2",
    "c.le.d","ffx","2",
    "c.le.s","ffx","2",
    "c.lt.d","ffx","2",
    "c.lt.s","ffx","2",
    "ceil.w.d","ffx","1",
    "ceil.w.s","ffx","1",
    "clo","rrx","1",
    "clz","rrx","1",
    "cvt.d.s","ffx","1",
    "cvt.d.w","ffx","1",
    "cvt.s.d","ffx","1",
    "cvt.s.w","ffx","1",
    "cvt.w.d","ffx","1",
    "cvt.w.s","ffx","1",
    "div","rrx","1",
    "div.d","fff","1",
    "div.s","fff","1",
    "divu","rrx","1",
    "eret","xxx","2",
    "floor.w.d","ffx","1",
    "floor.w.s","ffx","1",
    "j","lxx","2",
    "jal","lxx","2",
    "jalr","rrx","2",
    "jr","rrx","2",
    "lb","rsx","2",
    "lbu","rsx","2",
    "ldc1","rsx","2",
    "lh","rsx","2",
    "lhu","rsx","2",
    "ll","rsx","2",
    "lui","rix","2",
    "lw","rsx","2",
    "lwc1","rsx","2",
    "lwl","rsx","2",
    "lwr","rsx","2",
    "madd","rrx","1",
    "maddu","rrx","1",
    "mfc0","rrx","1",
    "mfc1","rfx","1",
    "mfhi","rxx","1",
    "mflo","rxx","1",
    "mov.d","ffx","1",
    "mov.s","ffx","1",
    "movf","rrx","1",
    "movf.d","ffx","1",
    "movf.s","ffx","1",
    "movn","rrx","1",
    "movn.d","ffx","1",
    "movn.s","ffx","1",
    "movt","rrx","1",
    "movt.d","ffx","1",
    "movt.s","ffx","1",
    "movz","rrx","1",
    "movz.d","ffx","1",
    "movz.s","ffx","1",
    "msub","rrx","1",
    "msubu","rrx","1",
    "mtc0","rrx","1",
    "mtc1","rfx","1",
    "mthi","rxx","1",
    "mtlo","rxx","1",
    "mul","rrr","1",
    "mul.d","fff","1",
    "mul.s","fff","1",
    "mult","rrx","1",
    "multu","rrx","1",
    "neg.d","ffx","1",
    "neg.s","ffx","1",
    "nop","xxx","1",
    "nor","rrr","1",
    "or","rrr","1",
    "ori","rri","1",
    "round.w.d","ffx","1",
    "round.w.s","ffx","1",
    "sb","rsx","2",
    "sc","rsx","2",
    "sdc1","rsx","2",
    "sh","rsx","2",
    "sll","rrx","1",
    "sllv","rrx","1",
    "slt","rrr","1",
    "slti","rri","1",
    "sltiu","rri","1",
    "sltu","rrr","1",
    "sra","rrx","1",
    "srav","rrx","1",
    "srl","rrx","1",
    "srlv","rrx","1",
    "sub","rrr","1",
    "sub.d","rrr","1",
    "sub.s","rrr","1",
    "subu","rrr","1",
    "sw","rsx","2",
    "swc1","rsx","2",
    "swl","rsx","2",
    "swr","rsx","2",
    "syscall","xxx","2",
    "teq","rrx","1",
    "teqi","rri","1",
    "tge","rrx","1",
    "tgei","rri","1",
    "tgeiu","rri","1",
    "tgeu","rrx","1",
    "tlbp","xxx","2",
    "tlbr","xxx","2",
    "tlbwi","xxx","2",
    "tlbwr","xxx","2",
    "tlt","rrx","1",
    "tlti","rri","1",
    "tltiu","rri","1",
    "tltu","rrx","1",
    "tne","rrx","1",
    "tnei","rri","1",
    "trunc.w.d","ffx","1",
    "trunc.w.s","ffx","1",
    "xor","rrr","1",
    "xori","rri","1"
    register: .asciiz "$zero", "$at", "$v0", "$v1", "$a0", "$a1", "$a2", "$a3", "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7", "$s0", "$s1", "$s2", "$s3", "$s4", "$s5", "$s6", "$s7", "$t8", "$t9", "$k0", "$k1", "$gp", "$sp", "$fp", "$ra"
    float: .asciiz "$f0", "$f1", "$f2", "$f3", "$f4", "$f5", "$f6", "$f7", "$f8", "$f9", "$f10", "$f11", "$f12", "$f13", "$f14", "$f15", "$f16", "$f17", "$f18", "$f19", "$f20", "$f21", "$f22", "$f23", "$f24", "$f25", "$f26", "$f27", "$f28", "$f29", "$f30", "$f31"
    immediate: .asciiz "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"
    newline: "\n"
    space: " "
    null: "\0"
    comma: ","
.text
read_instruction:
    #Prompt user to enter an instruction
    li $v0, 4
    la $a0, prompt
    syscall
    #Read the instruction, store at "input" address
    li $v0, 8
    la $a0, input
    li $a1, 100
    syscall

check_if_repeat:
    #Load addresses of strings into registers
    la $t0, input
    la $t1, stop
    #Compare strings
    loop:
        # Load a character from user input
        lb $t2, ($t0)
        # Load a character from stored string "stop"
        lb $t3, ($t1)
        # Compare characters, if not equal, jump to continue
        bne $t2, $t3, check_syntax
        # Characters are equal, check if the end of strings is reached. If reached end, jump to exit
        beqz $t2, check_end
        # Increment input pointer
        addi $t0, $t0, 1
        # Increment "stop" string pointer
        addi $t1, $t1, 1        
        j loop
    check_end:
    	beqz $t3, exit
    
check_syntax:
    split:
        #Extract opcode part of instruction
        opcode_part_init:
            #Load addresses of strings into registers
            la $s0, input
            la $s1, opcode_part
            la $s2, space
            la $s3, null
            la $s4, newline
            la $s5, comma
        #Loop to extract opcode part
        loop_opcode:
            #Load a character from user input
            lb $t0, ($s0)
            #If reach the end of opcode part in user input, jump to operand1_part
            #The end could be space, newline or null
            lb $t1, ($s2)
            beq $t0, $t1, skip_space1
            lb $t1, ($s3)
            beq $t0, $t1, processing
            lb $t1, ($s4)
            beq $t0, $t1, processing
            #Store the character into "opcode_part" string
            sb $t0, ($s1)
            #Increment input pointer
            addi $s0, $s0, 1
            #Increment "opcode_part" string pointer
            addi $s1, $s1, 1        
            j loop_opcode
        #Skip space 1
        skip_space1:
            addi $s0, $s0, 1
            lb $t0, ($s0)
            lb $t1, ($s2)
            beq $t0, $t1, skip_space1

        #Extract operand1 part of instruction
        operand1_part_init:
            la $s1, operand1  
        loop_operand1:
            #Load a character from user input
            lb $t0, ($s0)
            #If reach the end of operand 1 part in user input, jump to operand2_part
            #The end could be space, newline, null or comma
            lb $t1, ($s2)
            beq $t0, $t1, skip_space2
            lb $t1, ($s3)
            beq $t0, $t1, processing
            lb $t1, ($s4)
            beq $t0, $t1, processing
            lb $t1, ($s5)
            beq $t0, $t1, skip_comma1
            #Store the character into "operand 1 part" string
            sb $t0, ($s1)
            #Increment input pointer
            addi $s0, $s0, 1
            #Increment "operand 1 part" string pointer
            addi $s1, $s1, 1        
            j loop_operand1
        #Skip space 2
        skip_space2:
            addi $s0, $s0, 1
            lb $t0, ($s0)
            lb $t1, ($s2)
            beq $t0, $t1, skip_space2
            lb $t1, ($s5)
            bne $t0, $t1, operand2_part_init
        skip_comma1:
            addi $s0, $s0, 1
            lb $t0, ($s0)
            lb $t1, ($s2)
            bne $t0, $t1, operand2_part_init
        skip_space_after_comma1:
            addi $s0, $s0, 1
            lb $t0, ($s0)
            lb $t1, ($s2)
            beq $t0, $t1, skip_space_after_comma1

        #Extract operand2 part of instruction
        operand2_part_init:
            la $s1, operand2  
        loop_operand2:
            #Load a character from user input
            lb $t0, ($s0)
            #If reach the end of operand 2 part in user input, jump to operand2_part
            #The end could be space, newline, null or comma
            lb $t1, ($s2)
            beq $t0, $t1, skip_space3
            lb $t1, ($s3)
            beq $t0, $t1, processing
            lb $t1, ($s4)
            beq $t0, $t1, processing
            lb $t1, ($s5)
            beq $t0, $t1, skip_comma2
            #Store the character into "operand 2 part" string
            sb $t0, ($s1)
            #Increment input pointer
            addi $s0, $s0, 1
            #Increment "operand 2 part" string pointer
            addi $s1, $s1, 1        
            j loop_operand2
        #Skip space 3
        skip_space3:
            addi $s0, $s0, 1
            lb $t0, ($s0)
            lb $t1, ($s2)
            beq $t0, $t1, skip_space3
            lb $t1, ($s5)
            bne $t0, $t1, operand3_part_init
        skip_comma2:
            addi $s0, $s0, 1
            lb $t0, ($s0)
            lb $t1, ($s2)
            bne $t0, $t1, operand3_part_init
        skip_space_after_comma2:
            addi $s0, $s0, 1
            lb $t0, ($s0)
            lb $t1, ($s2)
            beq $t0, $t1, skip_space_after_comma2

        #Extract operand3 part of instruction
        operand3_part_init:
            la $s1, operand3  
        loop_operand3:
            #Load a character from user input
            lb $t0, ($s0)
            #If reach the end of operand 3 part in user input, jump to processing
            #The end could be space, newline, null
            lb $t1, ($s2)
            beq $t0, $t1, skip_space4
            lb $t1, ($s3)
            beq $t0, $t1, processing
            lb $t1, ($s4)
            beq $t0, $t1, processing
            #Store the character into "operand 3 part" string
            sb $t0, ($s1)
            #Increment input pointer
            addi $s0, $s0, 1
            #Increment "operand 3 part" string pointer
            addi $s1, $s1, 1        
            j loop_operand3
        #Skip space 4
        skip_space4:
            addi $s0, $s0, 1
            lb $t0, ($s0)
            lb $t1, ($s2)
            beq $t0, $t1, skip_space4
    processing:
    #Testing print
    li $v0, 4
    la $a0, opcode
    syscall
    li $v0, 4
    la $a0, opcode_part
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 4
    la $a0, operand
    syscall
    li $v0, 4
    la $a0, operand1
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 4
    la $a0, operand
    syscall
    li $v0, 4
    la $a0, operand2
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 4
    la $a0, operand
    syscall
    li $v0, 4
    la $a0, operand3
    syscall
    li $v0, 4
    la $a0, newline
    syscall
repeat:
    j read_instruction
exit:
    li $v0, 10
    syscall
