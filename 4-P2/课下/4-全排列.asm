.data
	sym:		.space	28
	ary:		.space	28
	nl:		.asciiz	"\n"
	space:	.asciiz " "

# index = a1
# i = a2

.text
	li		$s1, 1			# s1 : 1
	li		$v0, 5
	syscall
	move		$s0, $v0			# s0 : n
	li		$a1, 0			# a1 : index
	jal		fa
	li		$v0, 10
	syscall
	
fa:
if:
	bge		$a1, $s0, then
	j	if_end 
then:
	li		$t0, 0
print:
	beq		$t0, $s0, print_end
	
	sll		$t2, $t0, 2			# t2 : i*4
	lw		$a0, ary($t2)		# print ary(i*4)
	li		$v0,	 1
	syscall
	
	la		$a0, space
	li		$v0, 4
	syscall
	
	add		$t0, $t0, 1
	j		print
print_end:
	la		$a0, nl			# puts a newline
	li		$v0, 4
	syscall
	jr		$ra				# return

if_end:
	
	
	
	
	li		$a2, 0			# a2 : i
Loop:
	beq		$a2, $s0, Loop_end
	
	sll		$a3, $a2, 2		# a3 : i*4
	lw		$t0, sym($a3)	# t0 : sym(i*4)
if_0:
	beq		$t0, 0, then_0	# if(t0 == 0)
	j		if_0_end
then_0:
	add		$t2, $a2, 1		# t2 = i + 1
	sll		$t3, $a1, 2		# t3 : index*4
	sw		$t2, ary($t3)	# ary[index] = i+1
	sw		$s1, sym($a3)	# sym[i] = 1
	
	sub		$sp, $sp, 16
	sw		$ra, 16($sp)
	sw		$a1, 12($sp)
	sw		$a2, 8($sp)
	sw		$a3, 4($sp)
	
	add		$a1, $a1, 1
	jal		fa
	
	
	lw		$a3, 4($sp)
	lw		$a2, 8($sp)
	lw		$a1, 12($sp)
	lw		$ra, 16($sp)
	add		$sp, $sp, 16
	
	sw		$0, sym($a3)
if_0_end:	
	add		$a2, $a2, 1
	j		Loop
Loop_end:
	jr		$ra
	
	
	
	
	
	
