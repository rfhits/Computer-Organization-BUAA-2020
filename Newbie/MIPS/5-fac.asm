.text
	li		$v0, 5
	syscall
	move		$a0, $v0
	jal		fac
	li		$v0, 1
	syscall
	
	li		$v0, 10
	syscall
	
fac:

if:
	bne		$a0, 1, else
	jr		$ra
	
else:
	sw		$ra, 0($sp)
	sub		$sp, $sp, 4
	sw		$a0, 0($sp)
	sub		$sp, $sp, 4
	
	
	sub		$a0, $a0, 1
	jal		fac
	
	add		$sp, $sp, 4
	lw		$t0, 0($sp)
	add		$sp, $sp, 4
	lw		$ra, 0($sp)
	
	mul		$a0, $t0, $a0
	jr		$ra 
	
	
	
	
	
	
	
	