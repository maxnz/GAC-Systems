/* example of assembly programming - a hello world program
	RAB 10/29/21 */

/* string constants */
	.section .rodata
	.align 2
hello:				@ format string for printf
	.asciz "Hello, world!\n"

/* main program */
	.text
	.align 2
	.global main
main:
	push	{fp, lr}		@ setup stack frame
	add	fp, sp, #4
	sub	sp, sp, #0		@ no local variables, so #0

	ldr	r0, helloP		@ call printf
	bl	printf

	mov	r0, #0		@ return 0 from main
	sub	sp, fp, #4		@ tear down stack frame
	pop	{fp, pc}
	
/* pointer variable for format string */
	.align 2
helloP:	
	.word	 hello		@ pointer to string hello
