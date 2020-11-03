.data
    str:    .asciiz "Hello World"

.text
    li		$v0, 4		# $v0 = 4
    la		$a0, str
    syscall
    li		$v0, 10		# $v0 = 10
    syscall
    
