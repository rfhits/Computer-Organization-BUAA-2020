

.data
	ary:		.space	160
	
.text
	li		$v0, 5
	syscall
	move		$s0, $v0				# s0 is n
	
	li		$t0, 0
Store:
	beq		$t0, $s0, Store_end
	li		$v0, 12
	syscall
	sb		$v0, ary($t0)
	add		$t0, $t0, 1
	j		Store
Store_end:

	li		$t3, 1
	li		$t0, 0
Check:
	sll		$t2, $t0, 1
	add		$t2, $t2, 1
	bge		$t2, $s0, Output
	
	sub		$t1, $s0, $t0		# t1 = n-i-1
	sub		$t1, $t1, 1
	
	lb		$t4, ary($t0)
	lb		$t5, ary($t1)
If_same:	
	beq		$t4, $t5, Self_plus
Else:
	li		$t3, 0
	j		Output

Self_plus:
	add		$t0, $t0, 1
	j		Check
	
Output:

if_eq1:
	beq		$t3, 1, then
else:
	li		$a0, 0
	li		$v0, 1
	syscall
	j		End
then:
	li		$a0, 1
	li		$v0, 1
	syscall
	
End:
	li		$v0, 10
	syscall
