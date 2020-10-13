.macro	Exit
 li		$v0, 10
 syscall
.end_macro

.text
 li		$v0, 5			# get v0
 syscall
 move	$t0, $v0			# t0 is n (year)
 li		$v0, 1			# prepare to print
 li		$t1, 100			# t1 = 100
 li		$t2,	 4			# t2 = 4
 li		$t3, 400			# t3 = 400
 div		$t0, $t3			# t4 = n % 400
 mfhi	$t4
 beqz	$t4, Cout_1		
 div		$t0, $t1			
 mfhi	$t4				# t3 = n % 100
 beqz	$t4, Cout_0		# if t3 == 0, 
 div		$t0, $t2
 mfhi	$t4				# t3 = n % 4
 beqz	$t4, Cout_1		# if t3 == 0, go to Cout_1
 j		Cout_0			# 
 
 
 
 
 
Cout_0:
 li		$a0, 0
 syscall
 Exit
 
Cout_1:
 li		$a0, 1
 syscall
 Exit
 