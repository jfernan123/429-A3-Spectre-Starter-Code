victim_function:
.LFB3:
	.file 1 "spectre.c"
	.loc 1 35 32
	.cfi_startproc
	addi	sp,sp,-32
	.cfi_def_cfa_offset 32
	sd	ra,24(sp)
	sd	s0,16(sp)
	.cfi_offset 1, -8
	.cfi_offset 8, -16
	addi	s0,sp,32
	.cfi_def_cfa 8, 0
	sd	a0,-24(s0)
	.loc 1 36 9
	lui	a5,%hi(array1_size)
	lw	a5,%lo(array1_size)(a5) # loads array1_size
	slli	a5,a5,32
	srli	a5,a5,32
	.loc 1 36 6
	ld	a4,-24(s0)
	bgeu	a4,a5,.L3 
	.loc 1 37 26
	lui	a5,%hi(array1)
	addi	a4,a5,%lo(array1)
	ld	a5,-24(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)                # loads array1[x]
	sext.w	a5,a5
	.loc 1 37 30
	slliw	a5,a5,9
	sext.w	a5,a5
	.loc 1 37 19
	lui	a4,%hi(array2)
	addi	a4,a4,%lo(array2)
	add	a5,a4,a5
	lbu	a4,0(a5)                # loads array2[array1[x]*512]
	.loc 1 37 10
	lui	a5,%hi(temp)
	lbu	a5,%lo(temp)(a5)
	and	a5,a4,a5
	andi	a4,a5,0xff
	lui	a5,%hi(temp)
	sb	a4,%lo(temp)(a5)
.L3:
	.loc 1 39 1
	nop
	ld	ra,24(sp)
	.cfi_restore 1
	ld	s0,16(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 32
	addi	sp,sp,32
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc