# do not store all the number
# just store its value & #(col) & #(row) 
# output form tail to head

.macro r_and_c(%i, %n, %r, %c)	# i(index) --> #(row) and #(col)
	div		%i, %n
	mfhi 	%c
	mflo 	%r
	beqz 	%c, zhen
	nop
	addi		%r, %r, 1
	j		end	
zhen:
	move		%c, %n
end:	
	nop
.end_macro

.macro New_line					# cout a new line
 la		$a0, new_line
 li		$v0, 4
 syscall
.end_macro

.macro Space						# cout " "
 la		$a0, space
 li		$v0, 4
 syscall
.end_macro

.data 
 info: .space 2500				# store not 0 number and its info
 space: .asciiz " "
 new_line: .asciiz "\n"

.text
 li		$v0, 5
 syscall
 move	$s0, $v0			# s0 = n, #(row)
 
 li		$v0, 5
 syscall
 move	$s1, $v0			# s1 = m, #(col)
 
 mult	$s0, $s1
 mflo	$s2					# s2 = n x m
 
 li		$t0, 0				# t0 = i
 li		$t1, 0				# t1 is offset
 li		$t2, 0				# whether new line
 
 # t3 row
 # t4 col
Loop_input:					# just store info
 beq		$t0, $s2, Output		# (i == n) -> finish -> output
 li		$v0, 5
 syscall
 addi	$t0, $t0, 1			# i++
 beqz	$v0, Loop_input		# if (input == 0), do not store 
 
Store_info: 
 r_and_c($t0, $s1, $t3, $t4)
 # t3 row
 # t4 col
 sw		$v0, info($t1)
 addi	$t1, $t1, 4
 sw		$t4, info($t1)
 addi	$t1, $t1, 4
 sw		$t3, info($t1)
 addi	$t1, $t1, 4
 j		Loop_input
 
Output:
 addi	$t1, $t1, -4
 blt		$t1, 0, Exit
 lw		$a0, info($t1)
 li		$v0, 1
 syscall
 Space
 
 addi	$t1, $t1, -4
 lw		$a0, info($t1)
 li		$v0, 1
 syscall
 Space
 
 addi	$t1, $t1, -4
 lw		$a0, info($t1)
 li		$v0, 1
 syscall
 Space
 
 beqz	$t1, Exit	# whether a new line
 New_line			# if no new line, exit
 j		Output
 
Exit:
 li		$v0, 10
 syscall