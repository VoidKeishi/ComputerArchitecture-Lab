.data
    #For printing message
    prompt: .asciiz "Enter an assembly instruction(Type 'stop' if you want to exit): "
    valid_opcode: .asciiz "Opcode: %s, valid\n"
    invalid_opcode: .asciiz "Invalid opcode\n"
    valid_operand: .asciiz "Operand: %s, valid\n"
    invalid_operand: .asciiz "Invalid operand\n"
    clock_cycles: .asciiz "Number of clock cycles: %d\n"
    #For comparing opcode
    add: .asciiz "add"
    sub: .asciiz "sub"
    mul: .asciiz "mul"
    div: .asciiz "div"
    and: .asciiz "and"
    or: .asciiz "or"
    xor: .asciiz "xor"
    nor: .asciiz "nor"
    slt: .asciiz "slt"
    sll: .asciiz "sll"
    srl: .asciiz "srl"
    sra: .asciiz "sra"
    jr: .asciiz "jr"
    addi: .asciiz "addi"
    andi: .asciiz "andi"
    ori: .asciiz "ori"
    xori: .asciiz "xori"
    slti: .asciiz "slti"
    beq: .asciiz "beq"
    bne: .asciiz "bne"
    lw: .asciiz "lw"
    sw: .asciiz "sw"
    j: .asciiz "j"
    jal: .asciiz "jal"
    #For comparing operand
    zero: .asciiz "$zero"
    at: .asciiz "$at"
    v0: .asciiz "$v0"
    v1: .asciiz "$v1"
    a0: .asciiz "$a0"
    a1: .asciiz "$a1"
    a2: .asciiz "$a2"
    a3: .asciiz "$a3"
    t0: .asciiz "$t0"
    t1: .asciiz "$t1"
    t2: .asciiz "$t2"
    t3: .asciiz "$t3"
    t4: .asciiz "$t4"
    t5: .asciiz "$t5"
    t6: .asciiz "$t6"
    t7: .asciiz "$t7"
    s0: .asciiz "$s0"
    s1: .asciiz "$s1"
    s2: .asciiz "$s2"
    s3: .asciiz "$s3"
    s4: .asciiz "$s4"
    s5: .asciiz "$s5"
    s6: .asciiz "$s6"
    s7: .asciiz "$s7"
    t8: .asciiz "$t8"
    t9: .asciiz "$t9"
    k0: .asciiz "$k0"
    k1: .asciiz "$k1"
    gp: .asciiz "$gp"
    sp: .asciiz "$sp"
    fp: .asciiz "$fp"
    ra: .asciiz "$ra"
    #For storing instruction
    input: .space 100
    #For other purpose
    stop: .asciiz "stop"    #If user want to exit
    null: "0"
.text
read_instruction:
#Prompt user to enter an instruction
    li $v0, 4
    la $a0, prompt
    syscall
#Read the instruction, store at "input" address
    li $v0, 8
    la $a0, input
    li $a1, 80
    syscall
#Print result
    li $v0, 4
    la $a0, input
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
        bne $t2, $t3, continue
        # Characters are equal, check if the end of strings is reached. If reached end, jump to exit
        beqz $t3, exit 
        # Increment input pointer
        addi $t0, $t0, 1
        # Increment "stop" string pointer
        addi $t1, $t1, 1        
        j loop
continue:
    #Jump back to read again
    j read_instruction
exit:
    li $v0, 10
    syscall
