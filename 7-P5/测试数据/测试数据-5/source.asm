ori $s0, $0, 0x102d
ori $s1, $0, 0x59c
ori $s2, $0, 0x72b
ori $s3, $0, 0xaa7
ori $s4, $0, 0x2dc
ori $s5, $0, 0x13c
ori $s6, $0, 0xb08

label_3: ori $s7, $0, 0xabc
j label_1

nop
label_1: jal label_2
nop
ori $k0, $0, 0x1

label_6: subu $k0, $k0, $k0
beq $k0, $0, label_3

nop
label_2: addu $t1, $s1, $s4
addu $at, $t1, $t1

label_9: sw $at, 0x0($0)
addu $t1, $s5, $s2
nop
addu $at, $t1, $t1
sw $at, 0x4($0)
addu $t1, $s7, $s3

label_12: nop
nop
addu $at, $t1, $t1
sw $at, 0x8($0)
jalr $k0, $ra

label_15: nop
j label_4

nop
label_4: jal label_5
nop
ori $s0, $0, 0x1
subu $s0, $s0, $s0
beq $s0, $0, label_6

label_18: 
nop
label_5: addu $t6, $s3, $s7
subu $at, $t6, $t6
sw $at, 0xc($0)
addu $t6, $s3, $s2

label_21: nop
subu $at, $t6, $t6
sw $at, 0x10($0)
addu $t6, $s4, $s0
nop
nop

label_24: subu $at, $t6, $t6
sw $at, 0x14($0)
jalr $s0, $ra
nop
j label_7

label_27: 
nop
label_7: jal label_8
nop
ori $s1, $0, 0x1
subu $s1, $s1, $s1
beq $s1, $0, label_9

label_30: 
nop
label_8: addu $t1, $s7, $s4
lw $s6, 0x14($0)
sw $s6, 0x18($0)
addu $t1, $s3, $s1
nop
lw $s0, 0x18($0)

label_33: sw $s0, 0x1c($0)
addu $t1, $s2, $s3
nop
nop
lw $s1, 0x1c($0)
sw $s1, 0x20($0)

label_36: jr $ra
nop
j label_10

nop
label_10: jal label_11

label_39: nop
ori $t0, $0, 0x1
subu $t0, $t0, $t0
beq $t0, $0, label_12

nop
label_11: addu $t3, $s7, $s7

label_42: lui $s7, 0xe54
sw $s7, 0x24($0)
addu $t3, $s5, $s5
nop
lui $s2, 0x54d

label_45: sw $s2, 0x28($0)
addu $t3, $s3, $s7
nop
nop
lui $s4, 0x803
sw $s4, 0x2c($0)
jalr $t0, $ra
nop

label_48: j label_13

nop
label_13: jal label_14
nop
ori $s2, $0, 0x1

label_51: subu $s2, $s2, $s2
beq $s2, $0, label_15

nop
label_14: addu $t0, $s7, $s4
ori $s6, $t0, 0xe31
sw $s6, 0x30($0)

label_54: addu $t0, $s1, $s1
nop
ori $s5, $t0, 0x3ff
sw $s5, 0x34($0)
addu $t0, $s5, $s3

label_57: nop
nop
ori $s0, $t0, 0xe75
sw $s0, 0x38($0)
jr $ra
nop

label_60: ori $s0, $0, 0x8a7
ori $s1, $0, 0x58
ori $s2, $0, 0x8be
ori $s3, $0, 0xdc
ori $s4, $0, 0x661
ori $s5, $0, 0xc5a
ori $s6, $0, 0xede

label_63: ori $s7, $0, 0x6cc
j label_16

nop
label_16: jal label_17
nop
ori $t9, $0, 0x1

label_66: subu $t9, $t9, $t9
beq $t9, $0, label_18

nop
label_17: subu $at, $s0, $s7
addu $at, $at, $at

label_69: sw $at, 0x3c($0)
subu $at, $s6, $s6
nop
addu $at, $at, $at
sw $at, 0x40($0)
subu $at, $s1, $s1

label_72: nop
nop
addu $at, $at, $at
sw $at, 0x44($0)
jr $ra

label_75: nop
j label_19

nop
label_19: jal label_20
nop
ori $s2, $0, 0x1
subu $s2, $s2, $s2
beq $s2, $0, label_21

nop
label_20: subu $t3, $s7, $s0
subu $at, $t3, $t3
sw $at, 0x48($0)
subu $t3, $s7, $s7
nop
subu $at, $t3, $t3
sw $at, 0x4c($0)
subu $t3, $s6, $s4
nop
nop
subu $at, $t3, $t3
sw $at, 0x50($0)
jr $ra
nop
j label_22

nop
label_22: jal label_23
nop
ori $t9, $0, 0x1
subu $t9, $t9, $t9
beq $t9, $0, label_24

nop
label_23: subu $a2, $s3, $s7
lw $s5, 0x50($0)
sw $s5, 0x54($0)
subu $a2, $s2, $s5
nop
lw $s1, 0x54($0)
sw $s1, 0x58($0)
subu $a2, $s1, $s0
nop
nop
lw $s2, 0x58($0)
sw $s2, 0x5c($0)
jalr $t9, $ra
nop
j label_25

nop
label_25: jal label_26
nop
ori $s3, $0, 0x1
subu $s3, $s3, $s3
beq $s3, $0, label_27

nop
label_26: subu $t7, $s6, $s2
lui $s4, 0x5a6
sw $s4, 0x60($0)
subu $t7, $s4, $s3
nop
lui $s7, 0xab9
sw $s7, 0x64($0)
subu $t7, $s5, $s4
nop
nop
lui $s2, 0xbae
sw $s2, 0x68($0)
jalr $s3, $ra
nop
j label_28

nop
label_28: jal label_29
nop
ori $s1, $0, 0x1
subu $s1, $s1, $s1
beq $s1, $0, label_30

nop
label_29: subu $t6, $s2, $s7
ori $s6, $t6, 0x28
sw $s6, 0x6c($0)
subu $t6, $s4, $s2
nop
ori $s7, $t6, 0x68a
sw $s7, 0x70($0)
subu $t6, $s7, $s1
nop
nop
ori $s0, $t6, 0x4c2
sw $s0, 0x74($0)
jr $ra
nop
ori $s0, $0, 0x192
ori $s1, $0, 0x158
ori $s2, $0, 0x869
ori $s3, $0, 0x3cd
ori $s4, $0, 0xdf
ori $s5, $0, 0xd22
ori $s6, $0, 0x4d6
ori $s7, $0, 0xdcb
j label_31

nop
label_31: jal label_32
nop
ori $t0, $0, 0x1
subu $t0, $t0, $t0
beq $t0, $0, label_33

nop
label_32: lw $a1, 0x74($0)
addu $at, $a1, $a1
sw $at, 0x78($0)
lw $a1, 0x78($0)
nop
addu $at, $a1, $a1
sw $at, 0x7c($0)
lw $a1, 0x7c($0)
nop
nop
addu $at, $a1, $a1
sw $at, 0x80($0)
jr $ra
nop
j label_34

nop
label_34: jal label_35
nop
ori $s3, $0, 0x1
subu $s3, $s3, $s3
beq $s3, $0, label_36

nop
label_35: lw $t2, 0x80($0)
subu $at, $t2, $t2
sw $at, 0x84($0)
lw $t2, 0x84($0)
nop
subu $at, $t2, $t2
sw $at, 0x88($0)
lw $t2, 0x88($0)
nop
nop
subu $at, $t2, $t2
sw $at, 0x8c($0)
jr $ra
nop
j label_37

nop
label_37: jal label_38
nop
ori $s0, $0, 0x1
subu $s0, $s0, $s0
beq $s0, $0, label_39

nop
label_38: lw $a1, 0x8c($0)
lw $s7, 0x8c($0)
sw $s7, 0x90($0)
lw $a1, 0x90($0)
nop
lw $s6, 0x90($0)
sw $s6, 0x94($0)
lw $a1, 0x94($0)
nop
nop
lw $s6, 0x94($0)
sw $s6, 0x98($0)
jr $ra
nop
j label_40

nop
label_40: jal label_41
nop
ori $t2, $0, 0x1
subu $t2, $t2, $t2
beq $t2, $0, label_42

nop
label_41: lw $a1, 0x98($0)
lui $s2, 0xe84
sw $s2, 0x9c($0)
lw $a1, 0x9c($0)
nop
lui $s5, 0xc10
sw $s5, 0xa0($0)
lw $a1, 0xa0($0)
nop
nop
lui $s6, 0x520
sw $s6, 0xa4($0)
jr $ra
nop
j label_43

nop
label_43: jal label_44
nop
ori $t4, $0, 0x1
subu $t4, $t4, $t4
beq $t4, $0, label_45

nop
label_44: lw $t6, 0xa4($0)
ori $s4, $t6, 0xc31
sw $s4, 0xa8($0)
lw $t6, 0xa8($0)
nop
ori $s6, $t6, 0xea5
sw $s6, 0xac($0)
lw $t6, 0xac($0)
nop
nop
ori $s6, $t6, 0x30f
sw $s6, 0xb0($0)
jr $ra
nop
ori $s0, $0, 0xf14
ori $s1, $0, 0x459
ori $s2, $0, 0x66c
ori $s3, $0, 0x20f
ori $s4, $0, 0x728
ori $s5, $0, 0xd7a
ori $s6, $0, 0x943
ori $s7, $0, 0x47
j label_46

nop
label_46: jal label_47
nop
ori $t2, $0, 0x1
subu $t2, $t2, $t2
beq $t2, $0, label_48

nop
label_47: lui $t5, 0x548
addu $at, $t5, $t5
sw $at, 0xb4($0)
lui $t5, 0x79d
nop
addu $at, $t5, $t5
sw $at, 0xb8($0)
lui $t5, 0x925
nop
nop
addu $at, $t5, $t5
sw $at, 0xbc($0)
jalr $t2, $ra
nop
j label_49

nop
label_49: jal label_50
nop
ori $a1, $0, 0x1
subu $a1, $a1, $a1
beq $a1, $0, label_51

nop
label_50: lui $a2, 0xb44
subu $at, $a2, $a2
sw $at, 0xc0($0)
lui $a2, 0x82b
nop
subu $at, $a2, $a2
sw $at, 0xc4($0)
lui $a2, 0x22c
nop
nop
subu $at, $a2, $a2
sw $at, 0xc8($0)
jr $ra
nop
j label_52

nop
label_52: jal label_53
nop
ori $t5, $0, 0x1
subu $t5, $t5, $t5
beq $t5, $0, label_54

nop
label_53: lui $a1, 0xca4
lw $s3, 0xc8($0)
sw $s3, 0xcc($0)
lui $a1, 0x83d
nop
lw $s2, 0xcc($0)
sw $s2, 0xd0($0)
lui $a1, 0x816
nop
nop
lw $s4, 0xd0($0)
sw $s4, 0xd4($0)
jr $ra
nop
j label_55

nop
label_55: jal label_56
nop
ori $t7, $0, 0x1
subu $t7, $t7, $t7
beq $t7, $0, label_57

nop
label_56: lui $a3, 0x28
lui $s0, 0xaaa
sw $s0, 0xd8($0)
lui $a3, 0x689
nop
lui $s2, 0xd9a
sw $s2, 0xdc($0)
lui $a3, 0xde4
nop
nop
lui $s4, 0xf59
sw $s4, 0xe0($0)
jalr $t7, $ra
nop
j label_58

nop
label_58: jal label_59
nop
ori $t9, $0, 0x1
subu $t9, $t9, $t9
beq $t9, $0, label_60

nop
label_59: lui $a3, 0xf50
ori $s0, $a3, 0x34a
sw $s0, 0xe4($0)
lui $a3, 0x2cc
nop
ori $s1, $a3, 0x9c6
sw $s1, 0xe8($0)
lui $a3, 0xfd4
nop
nop
ori $s6, $a3, 0x173
sw $s6, 0xec($0)
jalr $t9, $ra
nop
ori $s0, $0, 0xe8d
ori $s1, $0, 0xe1
ori $s2, $0, 0x26e
ori $s3, $0, 0x3bc
ori $s4, $0, 0xd8a
ori $s5, $0, 0x10
ori $s6, $0, 0xff9
ori $s7, $0, 0x631
j label_61

nop
label_61: jal label_62
nop
ori $t1, $0, 0x1
subu $t1, $t1, $t1
beq $t1, $0, label_63

nop
label_62: ori $v1, $s5, 0x86
addu $at, $v1, $v1
sw $at, 0xf0($0)
ori $v1, $s4, 0xca9
nop
addu $at, $v1, $v1
sw $at, 0xf4($0)
ori $v1, $s1, 0x5af
nop
nop
addu $at, $v1, $v1
sw $at, 0xf8($0)
jalr $t1, $ra
nop
j label_64

nop
label_64: jal label_65
nop
ori $t6, $0, 0x1
subu $t6, $t6, $t6
beq $t6, $0, label_66

nop
label_65: ori $t5, $s4, 0xb01
subu $at, $t5, $t5
sw $at, 0xfc($0)
ori $t5, $s4, 0x6cc
nop
subu $at, $t5, $t5
sw $at, 0x100($0)
ori $t5, $s0, 0xb33
nop
nop
subu $at, $t5, $t5
sw $at, 0x104($0)
jalr $t6, $ra
nop
j label_67

nop
label_67: jal label_68
nop
ori $t0, $0, 0x1
subu $t0, $t0, $t0
beq $t0, $0, label_69

nop
label_68: ori $t1, $s5, 0xfe9
lw $s1, 0x104($0)
sw $s1, 0x108($0)
ori $t1, $s5, 0x489
nop
lw $s3, 0x108($0)
sw $s3, 0x10c($0)
ori $t1, $s4, 0xe98
nop
nop
lw $s4, 0x10c($0)
sw $s4, 0x110($0)
jalr $t0, $ra
nop
j label_70

nop
label_70: jal label_71
nop
ori $t5, $0, 0x1
subu $t5, $t5, $t5
beq $t5, $0, label_72

nop
label_71: ori $a1, $s2, 0xbe2
lui $s1, 0x1fb
sw $s1, 0x114($0)
ori $a1, $s2, 0xa43
nop
lui $s2, 0x293
sw $s2, 0x118($0)
ori $a1, $s6, 0xc6d
nop
nop
lui $s6, 0x8b7
sw $s6, 0x11c($0)
jalr $t5, $ra
nop
j label_73

nop
label_73: jal label_74
nop
ori $s1, $0, 0x1
subu $s1, $s1, $s1
beq $s1, $0, label_75

nop
label_74: 
ori $a2, $s0, 0x22
ori $s4, $a2, 0x668
sw $s4, 0x120($0)
ori $a2, $s6, 0x84
nop
ori $s6, $a2, 0x73b
sw $s6, 0x124($0)
ori $a2, $s3, 0x4b5
nop
nop
ori $s1, $a2, 0x296
sw $s1, 0x128($0)
jalr $s1, $ra
nop
