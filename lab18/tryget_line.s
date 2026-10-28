/* tryget_line.s - ARM assembly example of calling s1lib function get_line
   If s1lib.s is in your directory, you can assemble and test this program using

	gcc -o tryget_line tryget_line.s hdlib.s
	./tryget_line

   RAB 10/2020 */

/* string constants */
	.section	.rodata
	.align 2
prompt:				@ format string for printf
	.asciz	"\nEnter a line of input (up to 99 chars):  "


/* main program */
	.text
	.align	2
	.global	main
main:
	push	{fp, lr}   @ setup stack frame
	add 	fp, sp, #4
	@sub	sp, sp, #8	@ no local variables (commented this line out)

	ldr	r0, promptP  @ print prompt
	bl	printf

	ldr	r0, buffP    @ call get_line(buff, 100)
	mov	r1, #100
	bl	get_line

  @ return value r0 now holds number of bytes that were read
	bl	print_dec    @ call print_dec(return value)
	
  ldr	r0, buffP    @ call puts(buff)
	bl	puts		     @ (puts instead of printf since buff may have %)

	mov	r0, #0		@ return 0
	sub	sp, fp, #4	@ tear down stack frame and return
	pop	{fp, pc}

/* pointer variables for locations in .rodata and .data sections */
		.align	2
buffP:	.word	buff
promptP: .word	prompt
	

/* string variable */
		.data
		.align	2
buff:	.skip	100		@ array of char for input via get_line()
