.macro get_index(%ans, %n, %i, %j)
	mul		%ans, %i, %n
	add		%ans, %ans, %j		# i*n + j
	sll		%ans, %ans, 2
.end_macro

.data
	A:	.space	256
	B:	.space	256
	C:	.space	256
	nl:	.asciiz	"\n"
	space:	.asciiz	" "
	
	
.text
	li		$v0, 5
	syscall
	move		$s0, $v0					# n is $s0
	add		$t8, $s0, -1
	
	li		$t0, 0
A_i:
	beq		$t0, $s0, A_i_end
	li		$t1, 0
A_j:
	beq		$t1, $s0, A_j_end
	li		$v0, 5
	syscall
	move		$s1, $v0
	get_index($t2, $s0, $t0, $t1)		# 
	sw		$s1, A($t2)
	add		$t1, $t1, 1
	j		A_j
A_j_end:
	add		$t0, $t0, 1
	j		A_i
A_i_end:

	li		$t0, 0
	li		$t1, 0


B_i:
	beq		$t0, $s0, B_i_end
	li		$t1, 0
B_j:
	beq		$t1, $s0, B_j_end
	li		$v0, 5
	syscall
	move		$s1, $v0
	get_index($t2, $s0, $t0, $t1)		# 
	sw		$s1, B($t2)
	add		$t1, $t1, 1
	j		B_j
B_j_end:
	add		$t0, $t0, 1
	j		B_i
B_i_end:

	li		$t0, 0		# t0 is i
	li		$t1, 0		# t1 is j
	li		$t2, 0		# t2 is k
	
C_i:
	beq		$t0, $s0, C_i_end
	li		$t1, 0
C_j:
	beq		$t1, $s0, C_j_end
	li		$t2, 0
C_k:
	beq		$t2, $s0, C_k_end
	get_index($t3, $s0, $t0, $t2)		# A[i][k]
	lw		$t3, A($t3)				# $t3 is A[i][k]
	
	get_index($t4, $s0, $t2, $t1)		# B[k][j]
	lw		$t4, B($t4)				# t4 is B[k][j]
	
	get_index($t5, $s0, $t0, $t1)		# C[i][j]
	lw		$t6, C($t5)
	
	mul		$t3, $t3, $t4
	add		$t6, $t6, $t3
	sw		$t6, C($t5)
	add		$t2, $t2, 1
	j		C_k
C_k_end:
	add		$t1, $t1, 1
	j		C_j
	
C_j_end:
	add		$t0, $t0, 1
	j		C_i
C_i_end:
	
	li		$t0, 0
	li		$t1, 0
	
Out_i:
	beq		$t0, $s0, Out_i_end
	li		$t1, 0
Out_j:
	beq		$t1, $s0, Out_j_end
	get_index($t2, $s0, $t0, $t1)		# t2 is C[i][j]
	lw		$a0, C($t2)
	li		$v0, 1
	syscall
if:
	beq		$t1, $t8, then
	la		$a0, space
	li		$v0, 4
	syscall
	j		if_end
then:
	
	beq		$t0, $t8, Done
	la		$a0, nl
	li		$v0,4
	syscall
if_end:
	
	add		$t1, $t1, 1
	j		Out_j
Out_j_end:

	add		$t0, $t0, 1
	j		Out_i
Out_i_end:

Done:
	li		$v0, 10
	syscall	

	



	
	



	