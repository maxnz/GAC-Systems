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
	.file	"sumabs2.c"
	.text
	.align	2
	.global	abs2
	.syntax unified
	.arm
	.type	abs2, %function
abs2:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	bge	.L2
	ldr	r3, [fp, #-8]
	rsb	r3, r3, #0
	b	.L3
.L2:
	ldr	r3, [fp, #-8]
.L3:
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	abs2, .-abs2
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Enter minimum and maximum integer values:  \000"
	.align	2
.LC1:
	.ascii	"%d %d\000"
	.align	2
.LC2:
	.ascii	"The sum of absolute values is %d\012\000"
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	mov	r3, #0
	str	r3, [fp, #-8]
	ldr	r0, .L8
	bl	printf
	sub	r2, fp, #20
	sub	r3, fp, #16
	mov	r1, r3
	ldr	r0, .L8+4
	bl	__isoc99_scanf
	ldr	r3, [fp, #-16]
	str	r3, [fp, #-12]
	b	.L5
.L6:
	ldr	r0, [fp, #-12]
	bl	abs2
	mov	r2, r0
	ldr	r3, [fp, #-8]
	add	r3, r3, r2
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L5:
	ldr	r3, [fp, #-20]
	ldr	r2, [fp, #-12]
	cmp	r2, r3
	ble	.L6
	ldr	r1, [fp, #-8]
	ldr	r0, .L8+8
	bl	printf
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L9:
	.align	2
.L8:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.size	main, .-main
	.ident	"GCC: (Raspbian 14.2.0-19+rpi1) 14.2.0"
	.section	.note.GNU-stack,"",%progbits
