.section .data

#menus
	cheers:	.asciz	"\nWaga porugamu youkosou!\n"
	menu:	.asciz	"\nChoose an option:\n1 - Insert\n2 - Remove\n3 - Find\n4 - Show\n5 - Update\n0 - Leave\n> "
	empty:	.asciz	"\nEmpty list.\n"
	done:	.asciz	"\nSuccessfully added.\n"

#questions
	name:	.asciz	"\nEnter the name: "
	day:	.asciz	"\nEnter the birth day: "
	month:	.asciz	"\nEnter the birth month: "
	year:	.asciz	"\nEnter the birth year: "
	gender:	.asciz	"\nEnter the gender (M/F): "
	job:	.asciz	"\nEnter the job: "
	income:	.asciz	"\nEnter the income: "
	nfound:	.asciz	"\nName not found. \n"

#print_info
	pname:		.asciz	"Name: %s\n"
	pbirth:		.asciz	"Birthday: %d/%d/%d\n"
	pgend:		.asciz	"Gender: %c\n"
	pjob:		.asciz	"Job: %s\n"
	pinco:		.asciz	"Income: %.2lf\n"
	pos:		.asciz	"\npos = %d\n"
	comp:		.asciz	"\n%s = %s\n"
	deleted:	.asciz	"\nRegister successfully deleted.\n"
	debug:		.asciz	"\n%d = %d\n"

#types
	ctype:		.asciz	"%c"
	itype:		.asciz	"%d"
	ftype:		.asciz	"%f"

#pointers and constants
	NULL:		.int	0
	size:		.int	168
	new:		.int	NULL
	next:		.int	NULL
	last:		.int	NULL
	choice:		.int	NULL
	beggin:		.int	NULL

#useless?
	sname:		.space	64
	sday:		.space	8
	smonth:		.space	8
	syear:		.space	8
	sgender:	.space	8
	sjob:		.space	64
	sincome:	.space	8

.section .text
.globl _main

_main:
	jmp		beg

#SEARCH OK?
	find:
		movl	beggin, %edi
		cmpl	$NULL, %edi
		je		empty_list

		pushl	$name
		call	_printf
		addl	$4, %esp

		pushl	$sname
		call	_gets
		addl	$4, %esp

	check_next:
		pushl	%edi
		pushl	$sname
		call	_strcasecmp
		addl	$8, %esp

		cmpl	$0, %eax
		je		found

		cmpl	$NULL, 164(%edi)
		je		not_found
		movl	%edi, last
		movl	164(%edi), %edi
		jmp		check_next

	found:
		call	print_info
		jmp		leave_search

	not_found:
		pushl	$nfound
		call	_printf
		addl	$4, %esp

	leave_search:
	RET

#INSERTION OK?

	alloc:
		pushl	size
		call	_malloc
		addl	$4, %esp
		movl	%eax, new
		movl	new, %edi
	RET

	data:
		#nome
			pushl	%edi
			pushl	$name
			call	_printf
			addl	$4, %esp
			call	_gets

			popl	%edi
			addl	$64, %edi
		#day
			pushl	%edi
			pushl	$day
			call	_printf
			addl	$4, %esp

			pushl	$itype
			call	_scanf
			addl	$4, %esp

			popl	%edi
			addl	$8, %edi
			call	_getchar
		#month
			pushl	%edi
			pushl	$month
			call	_printf
			addl	$4, %esp

			pushl	$itype
			call	_scanf
			addl	$4, %esp

			popl	%edi
			addl	$8, %edi
			call	_getchar
		#year
			pushl	%edi
			pushl	$year
			call	_printf
			addl	$4, %esp

			pushl	$itype
			call	_scanf
			addl	$4, %esp

			popl	%edi
			addl	$8, %edi
			call	_getchar
		#gender
			pushl	%edi
			pushl	$gender
			call	_printf
			addl	$4, %esp

			pushl	$ctype
			call	_scanf
			addl	$4, %esp

			popl	%edi
			addl	$4, %edi
			call	_getchar
		#job
			pushl	%edi
			pushl	$job
			call	_printf
			addl	$4, %esp

			call	_gets

			popl	%edi
			addl	$64, %edi
		#income
			pushl	%edi
			pushl	$income
			call	_printf
			addl	$4, %esp

			pushl	$ftype
			call	_scanf
			addl	$4, %esp

			popl	%edi
			addl	$8, %edi
			call	_getchar

		subl	$164, %edi
	RET

	insert:
		call	alloc
		call	data
		movl	beggin, %eax
		cmpl	$NULL, %eax
		jz		insert_empty

	offset:
		movl	%eax, last
		movl	164(%eax), %ebx
		movl	%ebx, next
		cmpl	$NULL, next
		jz		insert_reg

		pushl	next
		pushl	%edi
		call	_strcasecmp
		addl	$8, %esp
		cmpl	$0, %eax
		jle		insert_reg

		movl	next, %eax
		jmp		offset

	insert_reg:
		movl	next, %eax
		movl	last, %ebx
		movl	%edi, 164(%ebx)
		movl	%eax, 164(%edi)
		jmp		end_insert

	insert_empty:
		movl	$NULL, 164(%edi)
		movl	%edi, beggin

	end_insert:
		pushl	$done
		call	_printf
		addl	$4, %esp
	RET

#REMOTION OK?
	remove:
		call	find
		cmpl	%edi, beggin
		je		beggin_remove

		else_remove:
			movl	last, %esi
			movl	164(%edi), %eax
			movl	%eax, 164(%esi)
			pushl	%edi
			call	_free

			pushl	$deleted
			call	_printf
			addl	$4, %esp
		RET

		beggin_remove:
			movl	164(%edi), %eax
			movl	%eax, beggin
			pushl	%edi
			call	_free

			pushl	$deleted
			call	_printf
			addl	$4, %esp
		RET

#PRINT OK?
	print_info:
		finit
		#prints name
			pushl	%edi
			pushl	$pname
			call	_printf
			addl	$4, %esp

		#next field in %edi
			popl	%edi
			addl	$64, %edi
			pushl	%edi

		#stack 3 fields to print birthday
			addl	$16, %edi
			pushl	(%edi)

			subl	$8, %edi
			pushl	(%edi)

			subl	$8, %edi
			pushl	(%edi)

			pushl	$pbirth
			call	_printf
			addl	$24, %esp

		#jumps 3 fields (3*8) in order of birthday
			popl	%edi
			addl	$24, %edi
			pushl	%edi

		#prints gender
			pushl	(%edi)
			pushl	$pgend
			call	_printf
			addl	$8, %esp

		#go to the job field in %edi
			popl	%edi
			addl	$4, %edi
			pushl	%edi

		#prints job
			pushl	$pjob
			call	_printf
			addl	$4, %esp

		#jumps to the income field
			popl	%edi
			addl	$64, %edi
			pushl	%edi

		#prints income
			flds	(%edi)
			subl	$4, %esp
			fsts	(%esp)
			pushl	$pinco
			call	_printf
			addl	$8, %esp

		#returns %edi to the original state
			popl	%edi
			subl	$156, %edi
	RET

	empty_list:
		pushl	$empty
		call	_printf
		addl	$4, %esp
	RET

	list:
		movl	beggin, %edi
		cmpl	$NULL, %edi
		jz		empty_list

	show_all:
		call	print_info
		call	che
		movl	164(%edi), %eax
		movl	%eax, next
		movl	next, %edi
		cmpl	$NULL, next
		jnz		show_all
	RET

#UPDATE OK?
	update:
		call	remove
		call	insert
	RET

che:
	pushl	$cheers
	call	_printf
	addl	$4, %esp
RET

get_menu:
	pushl	$menu
	call	_printf
	addl	$4, %esp

	#askmenu
		pushl	$choice
		pushl	$itype
		call	_scanf
		addl	$8, %esp

		pushl	%eax
		call	_getchar
		addl	$4, %esp

	#compmenu
		cmpl	$1, choice
		jz		opt1
		cmpl	$2, choice
		jz		opt2
		cmpl	$3, choice
		jz		opt3
		cmpl	$4, choice
		jz		opt4
		cmpl	$5,	choice
		jz		opt5
		cmpl	$0, choice
		jz		finish

	opt1:
		call	insert
		jmp		get_menu
	opt2:
		call	remove
		jmp		get_menu
	opt3:
		call	find
		jmp		get_menu
	opt4:
		call	list
		jmp		get_menu
	opt5:
		call	update
		jmp		get_menu

beg:
	pushl	$cheers
	call	_printf
	addl	$4, %esp
	call	get_menu

finish:
	pushl	$0
	call	_exit
