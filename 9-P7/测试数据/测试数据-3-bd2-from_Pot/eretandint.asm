.text
li $5,0x98765432
li $6,0xfedcba98
ori $7,$0,0xfc01
mtc0 $7,$12
div $5,$6
mflo $6
label:
beq $0,$0,label
nop