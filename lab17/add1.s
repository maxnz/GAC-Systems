/* add1.s - Example of coding an ARM assembly function */

/* string constants */
	.section .rodata
	.align	2
prompt:			@ format string for printf
	.asciz "Enter an integer:  "
	.align	2
input:			@ format string for scanf
	.asciz "%d"
	.align	2
results:			@ format string for printf
	.asciz "The call add1(%d) returns %d\n"

/* function add1
	1 arg - integer value
	return - integer, the sum of arg1 plus 1 */
	.text
	.align	2
add1:	
	push	{fp, lr}	@ setup stack frame
	add	fp, sp, #4
	sub	sp, sp, #8	@ one local variables (argument)
	@ [fp, #-8] holds n, integer argument
	str	r0, [fp, #-8]	@ initialize argument n

	ldr	r0, [fp, #-8]	@ compute n+1
	add	r0, r0, #1

	@ r0 now holds desired return value
	sub	sp, fp, #4	@ tear down stack frame
	pop	{fp, pc}

/* main program */
	.text
	.align	2
	.global main
main:
	push	{fp, lr}	@ setup stack frame
	add	fp, sp, #4
	sub	sp, sp, #8	@ one local variables
	@ [fp, #-8] holds x, input integer

	ldr	r0, promptP	@ print prompt
	bl	printf

	ldr	r0, inputP	@ read values into x and y
	sub	r1, fp, #8	
	bl	__isoc99_scanf

	ldr	r0, [fp, #-8]	@ call add1(x)
	bl	add1

	mov	r2, r0		@ print results: r0 = add1(x)
	ldr	r0, resultsP	
	ldr	r1, [fp, #-8]
	bl	printf

	mov	r0, #0		@ load return value
	sub	sp, fp, #4	@ tear down stack frame
	pop	{fp, pc}

/* pointer variables for format strings  */
	.align	2
promptP: 	.word	prompt	
inputP:		.word	input	
resultsP:	.word	results	
