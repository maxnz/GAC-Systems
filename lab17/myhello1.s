/* myhello1.s - example of assembly programming
	modified to include a local variable
	RAB 10/20/2019 */

/* string constants */
	.section .rodata
	.align	2
hello:					@ format string for printf
	.asciz "Hello, world! x=%d\n"

/* main program */
	.text
	.align	2
	.global main
main:
	push	{fp, lr}		@ setup stack frame
	add	fp, sp, #4
	sub	sp, sp, #8		@ one local variable
	@ [fp, #-8] holds x, an integer

	mov	r0, #29			@ assign 29 to x
	str	r0, [fp, #-8]

	ldr	r1, [fp, #-8]		@ call printf(hello, x)
	ldr	r0, helloP
	bl	printf

	mov	r0, #0			@ return 0 from main
	sub	sp, fp, #4		@ tear down stack frame
	pop	{fp, pc}

/* pointer variable for format string */
	.align	2
helloP:	.word	hello			@ pointer to string hello
