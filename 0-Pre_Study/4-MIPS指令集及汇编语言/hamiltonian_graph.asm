# https://blog.csdn.net/Prime_min/article/details/101025628
# Translate the cpp code in that article to MIPS :-)
# Chinese is at the end of this file
# mail：wysj0117@gmail.com //I may not reply :-|

# https://buaaeducn-my.sharepoint.com/:f:/g/personal/wysj0117_buaa_edu_cn/EuWLzhpI1aFJn50gzVKwCNIBcYIc2-oddttxNY3MmJlgJA?e=ystxhJ



.macro get_int(%r)				# cin >> an int >> %register
	li		$v0, 5
	syscall
	move		%r, $v0
.end_macro

.macro get_index(%t, %x, %y)		# t <-- (x - 1) x n + y
	addi		%t, %x, -1			# index of 1 demension array
	mul		%t, %t, $s0
	add		%t, %t, %y
.end_macro


.data
	matrix:	.space 800		# adjecency matrix, 1d array
	path:	.space 40
 

.text
	get_int($s0)				# s0 = #(nodes) = n, (n x n) matrix
	get_int($s1)				# s1 = #(edges)
	li		$s2, 1			# s2 = 1 --> const. to set 1
	
	li		$t0, 0			# t0 is i
	
Store_edges:					# repeat #(edges) times, set boolean
	beq		$t0, $s1, End_store_edges
	
	get_int($t1)					# t1 is 1st node
	get_int($t2)					# t2 is 2nd node
	
	get_index($t3, $t1, $t2)		# t3 <-- f(t1, t2), t3 is the index
	mul		$t4, $t3, 4			# t4 is offset
	sw		$s2, matrix($t4)
	
	get_index($t3, $t2, $t1)		# t3 <-- get_index(t1, t2), t3 is the index
	mul		$t4, $t3, 4
	sw		$s2, matrix($t4)

	addi		$t0, $t0, 1
	j		Store_edges
 
End_store_edges:

	li		$t4, 4				# reset the offset
	sw		$s2, path($t4)		# path begin with: 1
	li		$a1, 2				# a1 is dfs's layer, begin with 2
	li		$a2, 2 				# a2 is mark, mark the nodes have been used, using binary
	li		$v0, 0

	beq		$s0, 1, trivial		# Trivial graph, #(node) = 1
	jal		dfs					# deepth first search
	
	
OUT:
	move		$a0, $v0				# v0 is return value
	li		$v0, 1
	syscall
	li		$v0, 10
	syscall
 
trivial:
	li	$v0, 1
	j	OUT

dfs:
	
	ble		$a1, $s0, Continu	# a1 <= s0 means (layer <= n)
	mul		$t9, $s0, 4			# t9 = n * 4
	lw		$t9, path($t9)		# t9 = path[n]
	li		$t1, 1				# t1 = 1
	get_index($t2, $t1, $t9)		# t2 =get_intdex(path[n], 1)
	mul		$t2, $t2, 4
	lw		$t2, matrix($t2)
	or		$v0, $v0, $t2
	j		Continu_end

Continu:
	li		$t0, 1				# t0 is currunt node, self-plus
	
Loop_begin:					# search a avariable node
	bgt		$t0, $s0, Continu_end	#
	
	
	srlv 	$t1, $a2, $t0	# t1 = ((mark >> i) & 1) == 0 ?
	and		$t1, $t1, 1		# is this node(i) been used?
	xor		$t1, $t1, 1
 

	subi		$t2, $a1, 1		# t2 = matrix[get_index(path[l-1], i)]
	mul		$t2, $t2, 4		# is there an edge between node(i) and the last node in the path
	lw		$t2, path($t2)	# t2 = path[l-1]
	get_index($t3, $t2, $t0)
	mul		$t3, $t3, 4
	lw		$t2, matrix($t3)

	and		$t3, $t1, $t2	# t3 = t1 & t2
	beq		$t3, 0, i_plus	# t3 == 1, the node is avariable


	sw		$ra, 0($sp)		# before we chose the node and to dfs again
	subi		$sp, $sp, 4		# we need to store the arguments of currunt state
	sw		$a1, 0($sp)
	subi		$sp, $sp, 4
	sw		$a2, 0($sp)
	subi		$sp, $sp, 4
	sw		$t0, 0($sp)
	subi		$sp, $sp, 4
 								# update the path and layer
	mul		$t1, $a1, 4			# t1 = l * 4
	sw		$t0, path($t1)		# path[l] = i
	sllv		$t2, $s2, $t0		# t2 = 1 << i
	xor		$a2, $a2, $t2		# mark = mark ^ t2
	
	addi		$a1, $a1, 1			# l++
	jal		dfs
i_plus:
	addi		$t0, $t0, 1
	j		Loop_begin

Continu_end:
	seq		$t7, $a1, 2		# bug fixer :((
	sgt		$t8, $t0, $s0
	and		$t6, $t7, $t8
	beq		$t6, $s2, End
	
	
	addi		$sp, $sp, 4
	lw		$t0, 0($sp)
	addi		$sp, $sp, 4
	lw		$a2, 0($sp)
	addi		$sp, $sp, 4
	lw		$a1, 0($sp)
	addi		$sp, $sp, 4
	lw		$ra, 0($sp)
	
	
	seq		$t7, $a1, 2		# bug fixer :(
	slt		$t8, $t0, $s0
	and		$t6, $t7, $t8
	beq		$t6, $s2, i_plus
	
End:	
	jr		$ra				# jump to $ra

# 所谓“path”，就是一种类似树状结构， 当条件允许，这棵树就挑一个节点（node）往下走，直到走到最后无路可走，检查最后的节点和第一个节点是不是有回路，这也是dsf的终止条件
# 要保存的信息： path，目前的路径， mark：已经使用的节点，2进制表示的
# mark decimal binary
# 		2		10		节点1被使用
# 		6		110		节点1、2被使用
#		10		1010	节点1、3被使用
