	.arch armv6
	.fpu vfp
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"rsum.c"
	.text
	.align	2
	.global	sum
	.syntax unified
	.arm
	.type	sum, %function
sum:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	bgt	.L2
	mov	r3, #0
	b	.L3
.L2:
	ldr	r3, [fp, #-8]
	sub	r3, r3, #1
	mov	r0, r3
	bl	sum
	mov	r2, r0
	ldr	r3, [fp, #-8]
	add	r3, r2, r3
.L3:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	sum, .-sum
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Enter a non-negative integer: \000"
	.align	2
.LC1:
	.ascii	"%d\000"
	.align	2
.LC2:
	.ascii	"The sum of the first %d positive integers is %d\012"
	.ascii	"\000"
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	ldr	r0, .L6
	bl	printf
	sub	r3, fp, #12
	mov	r1, r3
	ldr	r0, .L6+4
	bl	__isoc99_scanf
	ldr	r3, [fp, #-12]
	mov	r0, r3
	bl	sum
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-12]
	ldr	r2, [fp, #-8]
	mov	r1, r3
	ldr	r0, .L6+8
	bl	printf
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L7:
	.align	2
.L6:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.size	main, .-main
	.ident	"GCC: (Raspbian 14.2.0-19+rpi1) 14.2.0"
	.section	.note.GNU-stack,"",%progbits
