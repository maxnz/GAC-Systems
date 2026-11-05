/* testget_byte.s - ARM assembly test program for get_byte() */

/* string constants */
	.section .rodata
	.align	2
prompt:			@ format string for printf
	.asciz "Enter a line of length 5 or more:  "
	.align	2
results:			@ format string for printf
	.asciz "The characters with index 1 and 4 are '%c' and '%c'\n"

/* array variable */
	.data
	.align	2
buff:	.skip	100		@ to hold input string from get_line

/* main program */
	.text
	.align	2
	.global main
main:
	push	{fp, lr}	@ setup stack frame
	add	fp, sp, #4
	sub	sp, sp, #8	@ 2 local variables
	@ [fp, #-8] holds char1, ASCII character buff[1]
	@ [fp, #-12] holds char4, ASCII character buff[4]

	ldr	r0, promptP	@ print prompt
	bl	printf

	ldr	r0, buffP	@ read line of input into buff
	mov	r1, #100
	bl	get_line

	ldr	r0, buffP	@ assign character at buff[1] to char1
	mov	r1, #1
	bl	get_byte
	str	r0, [fp, #-8]
	ldr	r0, buffP	@ assign character at buff[4] to char4
	mov	r1, #4
	bl	get_byte
	str	r0, [fp, #-12]

	ldr	r0, resultsP	@ print results
	ldr	r1, [fp, #-8]
	ldr	r2, [fp, #-12]
	bl	printf

	mov	r0, #0		@ load return value
	sub	sp, fp, #4	@ tear down stack frame
	pop	{fp, pc}

/* pointer variables for format strings and array variablen */
	.align	2
promptP: 	.word	prompt	
buffP:		.word	buff
resultsP:	.word	results	
