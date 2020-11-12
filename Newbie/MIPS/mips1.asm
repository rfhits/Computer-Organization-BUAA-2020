.text
	ori	$s0,$zero,7
	ori	$s1,$zero,7
	jal	monday

	ori	$s1,$zero,15
	j	end
monday:
	beq	$s0,$s1,equal
	ori	$s2,$zero,15
equal:
	ori	$s4,$zero,1
	jr	$ra
end:
	addu	$s3,$s1,$s2