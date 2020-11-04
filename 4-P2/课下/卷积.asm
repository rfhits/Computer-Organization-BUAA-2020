.macro get_index(%ans, %n, %i, %j)
	mul		%ans, %i, %n
	add		%ans, %ans, %j
	sll		%ans, %ans, 2
.end_macro

.macro get_int(%s)
	li		$v0, 5
	syscall
	move		%s, $v0
.end_macro

.data
	A:			.space	400
	B:			.space	400
	C:			.space	400
	space:		.asciiz " "
	new_line:	.asciiz "\n"
	
.text
	get_int($s0)		# s0 = m1
	get_int($s1)		# s1 = n1
	get_int($s2)		# s2 = m2
	get_int($s3)		# s3 = n2
	
	li		$t0, 0
A_i:
	beq		$t0, $s0, A_i_end
	
	li		$t1, 0
A_j:
	beq		$t1, $s1, A_j_end
	
	get_index($t2, $s1, $t0, $t1)
	get_int($t3)						
	sw		$t3, A($t2)
	add		$t1, $t1, 1
	j		A_j
A_j_end:
	add		$t0, $t0, 1
	j		A_i
A_i_end:
	
	
	li		$t0, 0				# t0 is i
B_i:
	beq		$t0, $s2, B_i_end
	
	li		$t1, 0				# t1 is j
B_j:
	beq		$t1, $s3, B_j_end
	
	get_index($t2, $s3, $t0, $t1)		# t2 is index
	get_int($t3)						# t3 = get()
	sw		$t3, B($t2)				# B[i][j] = t3
	add		$t1, $t1, 1
	j		B_j
B_j_end:
	add		$t0, $t0, 1
	j		B_i
B_i_end:

	sub		$s4, $s0, $s2
	add		$s4, $s4, 1				# s4 = m1-m2+1
	
	sub		$s5, $s1, $s3
	add		$s5, $s5, 1				# s5 = n1-n2+1
	sub		$s6, $s5, 1				# s6 = s5 - 1
	sub		$s7, $s4, 1				# s7	 = s4 -1
	
	li		$t0, 0
i:
	beq		$t0, $s4, i_end
	li		$t1, 0
j:
	beq		$t1, $s5, j_end
	li		$t2, 0
k:
	beq		$t2, $s2, k_end
	li		$t3, 0
l:
	beq		$t3, $s3, l_end
	
	get_index($t4, $s5, $t0, $t1)		# t4 = [i][j]
	lw		$t5, C($t4)				# t5 = C[t4]
	
	add		$t6, $t0, $t2			# t6 = i+k
	add		$t7, $t1, $t3			# t7 = j+l
	get_index($t8, $s1, $t6, $t7)		# t8 = [t6][t7]
	lw		$t8, A($t8)				# t8 = A[i+k][j+l]
	
	get_index($t6, $s3, $t2, $t3)		#
	lw		$t6, B($t6)				# t6 = B[k][l]
	
	mul		$t7, $t8, $t6
	add		$t5, $t5, $t7
	sw		$t5, C($t4)
	
	add		$t3, $t3, 1
	j		l
l_end:
	add		$t2, $t2, 1
	j		k
k_end:

	add		$t1, $t1, 1
	j		j
j_end:
	add		$t0, $t0, 1
	j		i
i_end:	
	
	li		$t0, 0
Out_i:
	beq		$t0, $s4, Out_i_end
	li		$t1, 0
Out_j:
	beq		$t1, $s5, Out_j_end
	
	get_index($t2, $s5, $t0, $t1)
	lw		$a0, C($t2)				# output C[i][j]
	li		$v0, 1
	syscall

if:
	beq		$t1, $s6, then
else:
	la		$a0, space		# puts a space
	li		$v0, 4
	syscall
	j		if_end
	
	
then:
	beq		$t0, $s7, End
	la		$a0, new_line
	li		$v0, 4
	syscall					# puts new_line
	
if_end:	
	add		$t1, $t1,1
	j		Out_j
Out_j_end:
	add		$t0, $t0, 1
	j		Out_i
Out_i_end:
	
	
	
End:
	li		$v0, 10
	syscall
	
	
	
