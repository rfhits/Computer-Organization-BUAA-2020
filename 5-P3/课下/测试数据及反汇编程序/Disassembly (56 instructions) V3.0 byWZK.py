# -*- coding: utf-8 -*-
"""
Created on Sat Nov  9 17:09:35 2019

@author: wzk
"""
import time


print("Function: machine code to mips code\n\
Instructions included: 56 (55 from mips-c instruction set and 'nop')\n\
Please copy the machine code into in.txt and put it into the same folder \
as this .py file.\nPress Enter to continue")

def bi_to_hex(a):
    return hex(int(str(int(a,2))))


machine=[]
hex_to_bi={"0":"0000","1":"0001","2":"0010","3":"0011",
           "4":"0100","5":"0101","6":"0110","7":"0111",
           "8":"1000","9":"1001","a":"1010","b":"1011",
           "c":"1100","d":"1101","e":"1110","f":"1111"}
reg={"0":"$0",  "1":"$at", "2":"$v0", "3":"$v1",
     "4":"$a0", "5":"$a1", "6":"$a2", "7":"$a3",
     "8":"$t0", "9":"$t1", "10":"$t2", "11":"$t3",
     "12":"$t4", "13":"$t5", "14":"$t6", "15":"$t7",
     "16":"$s0", "17":"$s1", "18":"$s2", "19":"$s3",
     "20":"$s4", "21":"$s5", "22":"$s6", "23":"$s7",
     "24":"$t8", "25":"$t9", "26":"$k0", "27":"$k1",
     "28":"$gp", "29":"$sp", "30":"$fp", "31":"$ra"}


mark=0
while mark==0:
    input()
    try:
         file_in = open('in.txt','rt')
         file_out = open('out.txt','wt')
         mark = 1
    except:
         print("in.txt does not exist. Please try again.")
         
out=["" for i in range(20000)]
labelcount=1
mipscount=0
label={}
for line in file_in:
    machine.append(line[:-1])
    
for hexcode in machine:
    
    bicode=""
    for char in hexcode:
        bicode += hex_to_bi[char]
        
    op=bicode[0:6]
    func=bicode[26:32]
    rs=reg[str(int(bicode[6:11],2))]
    rt=reg[str(int(bicode[11:16],2))]
    rd=reg[str(int(bicode[16:21],2))]
    shamt=bicode[21:26]
    imm=bi_to_hex(bicode[16:32])
    mips=""
    
    if op=='000000':
        itype="R"
    elif op=='000010' or op=='000011':
        itype="J"
    else:
        itype="I"
    
    if itype=="J":
        if op=='000010':
            mips="j "
        elif op=='000011':
            mips="jal "
        linenum=int((int(str(int(bicode[6:32]+"00",2)))-12288)/4)
        if not linenum in label.keys():
            labelname="label_"+str(labelcount)
            out[linenum] = labelname+": "+out[linenum]
            if linenum > 0:
                out[linenum-1]+="\n"
            label[linenum]=labelcount
            labelcount += 1
            mips = mips+labelname
        else:
            labelname="label_"+str(label[linenum])
            mips = mips+labelname
            
    elif itype=="R":
        if bicode=='00000000000000000000000000000000':
            mips="nop"
        elif func=='100000':
            mips="add "+rd+", "+rs+", "+rt
        elif func=='100001':
            mips="addu "+rd+", "+rs+", "+rt
        elif func=='100100':
            mips="and "+rd+", "+rs+", "+rt
        elif func=='001101':
            mips="break"
        elif func=='011010':
            mips="div "+rs+", "+rt
        elif func=='011011':
            mips="divu "+rs+", "+rt
        elif func=='001001':
            mips="jalr "+rd+", "+rs
        elif func=='001000':
            mips="jr "+rs
        elif func=='010000':
            mips="mfhi "+rd
        elif func=='010010':
            mips="mflo "+rd
        elif func=='010001':
            mips="mthi "+rd
        elif func=='010011':
            mips="mtlo "+rd
        elif func=='011000':
            mips="mult "+rs+", "+rt
        elif func=='011001':
            mips="multu "+rs+", "+rt
        elif func=='100111':
            mips="nor "+rd+", "+rs+", "+rt 
        elif func=='100101':
            mips="or "+rd+", "+rs+", "+rt 
        elif func=='000000':
            mips="sll "+rd+", "+rt+", "+shamt
        elif func=='000100':
            mips="sllv "+rd+", "+rt+", "+rs
        elif func=='101010':
            mips="slt "+rd+", "+rs+", "+rt
        elif func=='101011':
            mips="sltu "+rd+", "+rs+", "+rt
        elif func=='000011':
            mips="sra "+rd+", "+rt+", "+shamt
        elif func=='000111':
            mips="srav "+rd+", "+rt+", "+rs
        elif func=='000010':
            mips="srl "+rd+", "+rt+", "+shamt
        elif func=='000110':
            mips="srlv "+rd+", "+rt+", "+rs
        elif func=='100010':
            mips="sub "+rd+", "+rs+", "+rt
        elif func=='100011':
            mips="subu "+rd+", "+rs+", "+rt
        elif func=='001100':
            mips="syscall"
        elif func=='100110':
            mips="xor "+rd+", "+rs+", "+rt
    
    elif itype=="I":
        if op=='001000':
            mips="addi "+rt+", "+rs+", "+imm
        elif op=='001001':
            mips="addiu "+rt+", "+rs+", "+imm
        elif op=='001100':
            mips="andi "+rt+", "+rs+", "+imm
        elif op=='000100':
            mips="beq "+rs+", "+rt+", "
        elif op=='000001' and bicode[11:16]=='00001':
            mips="bgez "+rs+", "
        elif op=='000111':
            mips="bgtz "+rs+", "
        elif op=='000110':
            mips="blez "+rs+", "
        elif op=='000001' and bicode[11:16]=='00000':
            mips="bltz "+rs+", "
        elif op=='000101':
            mips="bne "+rs+", "+rt+", "
        elif op=='010000' and func=='011000':
            mips="eret"
        elif op=='100000':
            mips="lb "+rt+", "+imm+"("+rs+")"
        elif op=='100100':
            mips="lbu "+rt+", "+imm+"("+rs+")"
        elif op=='100001':
            mips="lh "+rt+", "+imm+"("+rs+")"
        elif op=='100101':
            mips="lhu "+rt+", "+imm+"("+rs+")"
        elif op=='001111':
            mips="lui "+rt+", "+imm
        elif op=='100011':
            mips="lw "+rt+", "+imm+"("+rs+")"
        elif op=='010000' and bicode[6:11]=='00000':
            mips="mfc0 "+rt+", "+rd
        elif op=='010000' and bicode[6:11]=='00100':
            mips="mtc0 "+rt+", "+rd
        elif op=='001101':
            mips="ori "+rt+", "+rs+", "+imm
        elif op=='101000':
            mips="sb "+rt+", "+imm+"("+rs+")"
        elif op=='101001':
            mips="sh "+rt+", "+imm+"("+rs+")"
        elif op=='001010':
            mips="slti "+rt+", "+rs+", "+imm
        elif op=='001011':
            mips="sltiu "+rt+", "+rs+", "+imm
        elif op=='101011':
            mips="sw "+rt+", "+imm+"("+rs+")"
        elif op=='001110':
            mips="xori "+rt+", "+rs+", "+imm
        if mips[0]=='b':
            imm=bicode[16:32]
            immv=int(15*imm[0]+imm,2)
            if imm[0]=='1':
                immv=-immv
            linenum= int( (mipscount+1+immv)/4)
            if not linenum in label.keys():
                labelname="label_"+str(labelcount)
                try:
                    out[linenum] = labelname+": "+out[linenum]
                except:
                    pass
                if linenum > 0:
                    out[linenum-1]+="\n"
                label[linenum]=labelcount
                labelcount += 1
                mips = mips+labelname
            else:
                labelname="label_"+str(label[linenum])
                mips = mips+labelname
    mips+="\n"
    out[mipscount] += mips
    mipscount += 1
    
print("".join(out))
file_out.write("".join(out))
#print(out)
print("MIPS code has been written in out.txt")
time.sleep(5)
file_in.close()
file_out.close()
    
    