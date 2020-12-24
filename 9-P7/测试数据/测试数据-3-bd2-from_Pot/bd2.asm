.text
li $5,0x3456789a
li $6,0x12349876
ori $7,$0,0xfc01
mtc0 $7,$12
mult $5,$6
beq $5,$5,next
mflo $7
xori $1,$1,1
next:
mfhi $8