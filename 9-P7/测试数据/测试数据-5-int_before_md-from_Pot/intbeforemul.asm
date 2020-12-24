.text
li $5,0x3456789a
li $6,0x12349876
ori $7,$0,0xfc01
mtc0 $7,$12
sw $6,0($0)
lw $5,0($0)
beq $0,$0,next
nop
mtlo $5
xori $1,$1,1
next:
mfhi $8