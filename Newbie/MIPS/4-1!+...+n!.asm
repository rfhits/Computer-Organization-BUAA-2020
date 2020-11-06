.text
	li		$v0, 5
	syscall
	
	move		$s0, $v0
	li		$s1, 1		# s1 : fac
	li		$s2, 0		# s2 : sum
	
	
	li		$t0, 1		# t0 : i
Loop:
	bgt		$t0, $s0, Loop_end
	
	mul		$s1, $s1, $t0	# fac = fac * i
	add		$s2, $s2, $s1	# sum = fac + sum
	
	add		$t0, $t0, 1
	j		Loop
Loop_end:
	li		$v0, 1
	move		$a0, $s2
	syscall
	
	li		$v0, 10
	syscall
	
	
	