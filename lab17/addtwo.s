/* addtwo.s - example of ARM coding with local variables */

/* string constants */
	.section .rodata
	.align 2
prompt:			@ format string for printf
	.asciz "Enter two integers:  "
	.align 2
input:			@ format string for scanf
	.asciz "%d %d"
	.align 2
results:			@ format string for printf
	.asciz "The sum of %d and %d is %d\n"

/* main program */
	.text
	.align 2
	.global main
main:
	push	{fp, lr}	@ setup stack frame
	add	fp, sp, #4
	sub	sp, sp, #16	@ 3 local variables
	@ [fp, #-8] holds x, first input integer
	@ [fp, #-12] holds y, second input integer
	@ [fp, #-16] holds sum, sum of x and y

	ldr	r0, promptP	@ print prompt
	bl	printf

	ldr	r0, inputP	@ read values into x and y
	sub	r1, fp, #8	
	sub	r2, fp, #12
	bl	__isoc99_scanf

	ldr	r2, [fp, #-8]	@ compute sum
	ldr	r3, [fp, #-12]
	add	r1, r2, r3
	str	r1, [fp, #-16]

	ldr	r0, resultsP	@ print results
	ldr	r1, [fp, #-8]	
	ldr	r2, [fp, #-12]	
	ldr	r3, [fp, #-16]
	bl	printf

	mov	r0, #0		@ load return value
	sub	sp, fp, #4	@ tear down stack frame
	pop	{fp, pc}

/* pointer variables for format strings  */
	.align 2
promptP: 	.word	prompt	
inputP:		.word	input	
resultsP:	.word	results	
