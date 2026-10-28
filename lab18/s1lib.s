/* Systems 1 library of utility functions - RAB, Fall 2018 */

/* print_dec
	1 arg - an integer
	state change - print arg1 in decimal on standard output
        return - integer 1 on success, 0 if no integer printed */

	.text
	.global	print_dec
	.align 2
print_dec:
	push	{fp, lr}	@ setup stack frame
	add 	fp, sp, #4
	@sub	sp, sp, #8	@ no local variables

	@assert - r0 contains integer value to print in decimal
	mov	r1, r0
	ldr	r0, print_dec_fmtP
	bl	printf
	@assert - return value from printf is desired return val from print_dec

	sub	sp, fp, #4	@ tear down stack frame and return
	pop	{fp, pc}

	.align	2
print_dec_fmtP:
	.word	print_dec_fmt

	.data
	.align	2
print_dec_fmt:
	.asciz	"%d"


/* print_hex
	1 arg - an integer
	state change - print arg1 in hexidecimal on standard output
        return - integer 1 on success, 0 if no integer printed */

	.text
	.global	print_hex
	.align 2
print_hex:
	push	{fp, lr}	@ setup stack frame
	add 	fp, sp, #4
	@sub	sp, sp, #8	@ no local variables

	@assert - r0 contains integer value to print in heximal
	mov	r1, r0
	ldr	r0, print_hex_fmtP
	bl	printf
	@assert - return value from printf is desired return val from print_hex

	sub	sp, fp, #4	@ tear down stack frame and return
	pop	{fp, pc}

	.align	2
print_hex_fmtP:
	.word	print_hex_fmt

	.data
	.align	2
print_hex_fmt:
	.asciz	"%x"



/* println_dec
	1 arg - an integer
	state change - print arg1 in decimal on standard output,
	     followed by a newline
        return - integer 1 on success, 0 if no integer printed */

	.text
	.global	println_dec
	.align 2
println_dec:
	push	{fp, lr}	@ setup stack frame
	add 	fp, sp, #4
	@sub	sp, sp, #8	@ no local variables

	@assert - r0 contains integer value to print in decimal
	mov	r1, r0
	ldr	r0, println_dec_fmtP
	bl	printf
	@assert - printf return value is desired return val from println_dec

	sub	sp, fp, #4	@ tear down stack frame and return
	pop	{fp, pc}

	.align	2
println_dec_fmtP:
	.word	println_dec_fmt

	.data
	.align	2
println_dec_fmt:
	.asciz	"%d\n"


/* println_hex
	1 arg - an integer
	state change - print arg1 in hexidecimal on standard output, 
	     followed by a newline
        return - integer 1 on success, 0 if no integer printed */

	.text
	.global	println_hex
	.align 2
println_hex:
	push	{fp, lr}	@ setup stack frame
	add 	fp, sp, #4
	@sub	sp, sp, #8	@ no local variables

	@assert - r0 contains integer value to print in heximal
	mov	r1, r0
	ldr	r0, println_hex_fmtP
	bl	printf
	@assert - printf return value is desired return val from println_hex

	sub	sp, fp, #4	@ tear down stack frame and return
	pop	{fp, pc}

	.align	2
println_hex_fmtP:
	.word	println_hex_fmt

	.data
	.align	2
println_hex_fmt:
	.asciz	"%x\n"



/* _byte_helper
	2 args - word-aligned memory address and non-negative integer index
	return - address (in r0) and index (in r1) for the byte that is
	    arg1 bytes after arg0, where 0 <= index < 3 */

	.text
	.global	__aeabi_idiv	@ integer quotient function in C library
	.align	2
_byte_helper:
	push	{fp, lr}	@ setup stack frame
	add 	fp, sp, #4
	sub	sp, sp, #8	@ 2 args variables
	@ [fp, #-8] holds addr, address of a word in memory
	@ [fp, #-12] holds offset, index of desired byte relative to addr

	str	r0, [fp, #-8]	@ store args in addr and offset
	str	r1, [fp, #-12]
	ldr	r0, [fp, #-12]	@ calculate integer quotient offset/4
	mov	r1, #4
	bl	__aeabi_idiv	
	ldr	r1, [fp, #-12]  @ subtract 4*quotient from offset
	sub	r1, r0,asl #2
	str	r1, [fp, #-12]
	ldr	r1, [fp, #-8]	@ add 4*quotient to addr
	add	r1, r1, r0,asl #2
	str	r1, [fp, #-8]
	
	mov 	r0, r1		@ return values addr and offset
	ldr	r1, [fp, #-12]
	sub	sp, fp, #4	@ tear down stack frame and return
	pop	{fp, pc}
	

/* get_byte
	2 args - word-aligned memory address and non-negative integer index
	return - integer whose lowest 8 bits are byte number arg2 after that 
	    address arg1

	Example - if "Hello, world!\n" is at address 1000, then
	    get_byte(1000, 0) --> 'H' = 0x00000048
	    get_byte(1000, 1) --> 'e' = 0x00000065
	    get_byte(1000, 12) --> '!' = 0x00000021
	    get_byte(1000, 14) --> '\0' = 0x00000000  */

	.text
	.global	get_byte
	.align	2
get_byte:
	push	{fp, lr}	@ setup stack frame
	add 	fp, sp, #4
	@sub	sp, sp, #8	@ no local variables needed

	@ assert - incoming arguments already hold args for call to helper
	bl	_byte_helper

	@ assert - desired byte is at addr r0+r1, where r0 is word-aligned
	@          and 0 <= r1 < 4
	ldr	r0, [r0]	@ copy word value stored at addr into r0
	mov	r1, r1,asl #3	@ r1 = offset * 8, number of bits to shift r0
	mov	r0, r0,lsr r1	@ extract desired byte from r0, into return r0
	and	r0, r0, #0xff

	sub	sp, fp, #4	@ tear down stack frame and return
	pop	{fp, pc}
	

/* put_byte
	3 args - a word-aligned memory address, a non-negative integer index, 
	    and an integer val whose lowest 8 bits hold an ASCII code to assign
	state change - that ASCII code is assigned to byte number arg2 after
	    that memory address arg1
	return - none */

	.text
	.global	put_byte
	.align	2
put_byte:
	push	{fp, lr}	@ setup stack frame
	add 	fp, sp, #4
	sub	sp, sp, #8	@ one local variable needed
	@ [fp, #-8] holds val, byte to assign, with 0 in upper three sig bytes

	and	r2, r2, #0xff	@ clean and store byte to assign in val
	str	r2, [fp, #-8]
	
	

	@ assert - incoming arguments already hold args for call to helper
	bl	_byte_helper

	@ assert - incoming arguments already hold args for call to helper
	bl	_byte_helper

	@ assert - desired byte is at address r0+r1, where 
	@          r0 is word-aligned and 0 <= r1 < 4
	ldr	r3, [r0]	@ copy word value to modify into r3
	mov	r1, r1,asl #3	@ r1 = offset * 8, number of bits to shift
	mov	r2, #0xff	@ clear byte to modify
	mvn	r2, r2,lsl r1
	and	r3, r3, r2
	ldr	r2, [fp, #-8]	@ shift val into position
	mov	r2, r2,lsl r1
	orr	r3, r3, r2	@ assign val to desired byte in memory word
	str	r3, [r0]

	sub	sp, fp, #4	@ tear down stack frame and return
	pop	{fp, pc}


/* get_line
	2 args - buff, a word-aligned array of bytes, and
	    max, a positive maximum number of bytes within buff
	state change - up to max-1 bytes are read from standard input
 	  and stored in buff, stopping at the first newline (if any).  
          Then a nullbyte is appended just after the final character 
          stored, UNLESS input ends before any bytes were read.
	return - the number of bytes read into buff, EXCEPT
	    0 is returned if end of input before any bytes were read, and
	    -1 is returned if an input error was encountered.  */

	.text
	.align	2
	.global	get_line
get_line:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	str	r0, [fp, #-16]
	str	r1, [fp, #-20]
	ldr	r3, .L5
	ldr	r3, [r3]
	ldr	r0, [fp, #-16]
	ldr	r1, [fp, #-20]
	mov	r2, r3
	bl	fgets
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	bne	.L2
	ldr	r3, .L5
	ldr	r3, [r3]
	mov	r0, r3
	bl	feof
	mov	r3, r0
	cmp	r3, #0
	beq	.L3
	mov	r3, #0
	b	.L4
.L3:
	mvn	r3, #0
	b	.L4
.L2:
	ldr	r0, [fp, #-16]
	bl	strlen
	mov	r3, r0
.L4:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L6:
	.align	2
.L5:
	.word	stdin
	.size	get_line, .-get_line
	.section	.rodata
	.align	2
.LC0:
	.ascii	"get_line() returned %d and read \"%s\"\012\000"
	
	
