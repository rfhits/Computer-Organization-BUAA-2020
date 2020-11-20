ori $1,11
ori $2,22
ori $3,33
lui $4,12
lui $5,23
lui $6,24
lui $7,25
lui $8,34
lui $9,12
addu $10,$9,$9
addu $11,$2,$3
addu $12,$5,$6
subu $13,$3,$5
subu $14,$5,$4
subu $15,$2,$6
nop
lui $16,12
beq $9,$16, next #应跳转
nop
lui $1,1
lui $2,1
lui $3,1
lui $4,1
haha:
lui $5,1
lui $6,1
lui $7,1
lui $8,1
lui $9,1
lui $10,1
next:
beq $1,$2,haha #应不跳转，否则死循环
sw $1,0($0)
sw $2,4($0)
sw $3,8($0)
sw $4,12($0)
sw $5,16($0)
sw $6,20($0)
sw $7,24($0)
lw $17,0($0)
lw $18,4($0)
jal ok 
lw $19, 8($0)
jal end
ok:
lw $0,0($0)
jr $31
end:
subu $3,$3,$0
subu $31,$0, $31
