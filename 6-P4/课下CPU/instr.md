# 指令简单说明

addu, subu, ori, lui, lw, sw, beq, jal, jr, nop

## cal_r

use register value to calculate

addu, subu

### addu

GRF[rd] <= GRF[rs] + GRF[rt]

### subu

GRF[rd] <= GRF[rs] - GRF[rt]

## cal_i

use the imm

### ori

GRF[rt] <= GRF[rs] or ZeroExt(imm16)

### lui

GPR[rt] <= {imm16, 16{0}}

## DM

### lw

MemAddr <= GRF[rs] + SignExt(imm16)  
GRF[rt] <= DM[MemAddr]

### sw

MemAddr <= GRF[rs] + SignExt(imm16)  
DM[MemAddr] <= GRF[rt]

## Branch

### beq

    if (GRF[rs] = GRF[rt]):  
        PC <= PC + 4 + SignExt({imm16, 2{0}})
    else :
        PC <= PC + 4

## J-Directly Jump

## j

PC <= {PC[31:28], imm26, 2{0}}

## jal

PC <= {PC[31:28], imm26, 2{0}}
GRF[31] <= PC + 4

## J-RegJump

## jr

PC <= GRF[rs]

## jalr

PC <= GRF[rs]
GRF[rd] <= PC + 4
