.data
	array:	.space	40
	space:	.asciiz	" "
	
.text
	li		$v0, 5
	syscall
	move		$s0, $v0
	li		$t0, 0
Input:
	beq		$t0, $s0, Input_end
	li		$v0, 5			# $v0 is n
	syscall
	sll		$t1, $t0, 2
	sw		$v0, array($t1)	# array[$t0*4] = $v0
	add		$t0, $t0, 1
	j		Input

Input_end:
	li		$t0, 0
	li		$t1, 0

Output:
	beq		$t0, $s0, Output_end
	sll		$t1, $t0, 2
	lw		$a0, array($t1)
	li		$v0, 1
	syscall
	li		$v0, 4
	la		$a0, space
	syscall
	add		$t0, $t0, 1
	j		Output

Output_end:
	li		$v0, 10
	syscall
		