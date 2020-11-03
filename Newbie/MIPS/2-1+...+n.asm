.text
	li		$v0, 5					# get n
	syscall
	li		$t0, 1
Loop:
	bgt		$t0, $v0, Loop_end		# for(i == 1; i <= n; i++)
	add		$a0, $t0, $a0			# ans = i + ans
	add		$t0, $t0, 1
	j		Loop
Loop_end:
	li		$v0, 1					# print(ans)
	syscall
	li		$v0, 10
	syscall