/* printsq.s - example of calling printf with a function */

/* string constants for printsq() */
	.section .rodata
	.align	2
label:			@ format string for printf() call
	.asciz "The square of %d is %d\n"

	.text
	.align	2
/* printsq
	1 arg - an integer, referred to as x
	state change - the values x and x*x are printed with labelling
	return - the integer value of x*x */
printsq:
	push	{fp, lr}	@ setup stack frame
	add	fp, sp, #4
	sub	sp, sp, #8	@ 2 local variables
	@ [fp, #-8] holds the argument, x
	@ [fp, #-12] holds the square, referred to as sq
	str	r0, [fp, #-8]	@ initialize x from argument

	mul	r1, r0, r0	@ assign x*x to sq
	str	r1, [fp, #-12]

	ldr	r0, labelP	@ print the results
	ldr	r1, [fp, #-8]
	ldr	r2, [fp, #-12]
	bl	printf

	ldr	r0, [fp, #-12]	@ return value sq
	sub	sp, fp, #4	@ tear down stack frame
	pop	{fp, pc}

	.align	2
labelP:	.word	label
	
/* string constants for main */

	.section .rodata
	.align	2
prompt:			@ format string for printf() call
	.asciz "Enter an integer:  "
	.align	2
input:			@ format string for scanf() call
	.asciz "%d"


/* main program */
	.text
	.align	2
	.global main
main:
	push	{fp, lr}	@ setup stack frame
	add	fp, sp, #4
	sub	sp, sp, #8	@ one local variable
	@ [fp, #-8] holds n, input integer

	ldr	r0, promptP	@ print prompt
	bl	printf
	ldr	r0, inputP	@ read input integer into n
	sub	r1, fp, #8
	bl	__isoc99_scanf

	ldr	r0, [fp, #-8]	@ call printsq
	bl	printsq

	mov	r0, #0		@ load return value
	sub	sp, fp, #4	@ tear down stack frame
	pop	{fp, pc}

/* pointer variables for format strings  */
	.align	2
promptP:
	.word	prompt	
inputP:	.word	input	
