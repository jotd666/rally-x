	.macro ERROR arg
	.error	"\arg"
	.endm
	.macro CLEAR_XC_FLAGS
	move.w	d7,-(a7)
	moveq	#0,d7
	roxl.b	#1,d7
	movem.w	(a7)+,d7
	.endm

	.macro SET_XC_FLAGS
	move.w	d7,-(a7)
	st	d7
	roxl.b	#1,d7
	movem.w	(a7)+,d7
	.endm

	.macro	INVERT_XC_FLAGS
	jcs	0f
	SET_XC_FLAGS
	bra.b	1f
0:
	CLEAR_XC_FLAGS
1:
	.endm

	.macro	SET_X_FROM_C
	jcc	0f
	SET_XC_FLAGS
	bra.b	1f
0:
	CLEAR_XC_FLAGS
1:
	.endm
	.macro	SET_C_FROM_X
	move.w	d7,-(a7)
	roxl.b	#1,d7
	roxr.b	#1,d7
	movem.w	(a7)+,d7
	.endm

	.macro	BREAK_IF_IN_SCREEN	reg
	cmp.w	#0x8400,\reg
	jcs		skip\@
	cmp.w	#0x8800,\reg
	jcc		skip\@
	jbsr	osd_get_last_known_pc
	BREAKPOINT	"loading 8400-8800 in \reg"
skip\@:
	.endm
	
* those macros use rol/ror instead of lsl/lsr
* which doesn't clear MSB/LSB but matters much less than
* leaving X untouched for next operations

	.macro	LOAD_D1_16_FROM_D1D2
	and.l	#0xFFFF,d1
	rol.w	#8,d1
	move.b	d2,d1
	.endm
	
	.macro	LOAD_D3_16_FROM_D3D4
	and.l	#0xFFFF,d3
	rol.w	#8,d3
	move.b	d4,d3
	.endm
	.macro	LOAD_D5_16_FROM_D5D6
	and.l	#0xFFFF,d5
	rol.w	#8,d5
	move.b	d6,d5
	.endm
	.macro	LOAD_D1D2_FROM_D1_16
	move.b	d1,d2
	ror.w	#8,d1
	.endm
	.macro	LOAD_D5D6_FROM_D5_16
	move.b	d5,d6
	ror.w	#8,d5
	.endm
	.macro	LOAD_D3D4_FROM_D3_16
	move.b	d3,d4
	ror.w	#8,d3
	.endm

	.macro	LOAD_A0_FROM_D5_16
	BREAK_IF_IN_SCREEN	d5
	lea	(a6,d5.l),a0
	.endm
	
	.macro	LOAD_A1_FROM_D3_16
	BREAK_IF_IN_SCREEN	d3
	lea	(a6,d3.l),a1
	.endm
	
	.macro	LOAD_D5_16_FROM_A0
	move.l	a0,d5
	sub.l	a6,d5
	.ifndef	RELEASE
	jpl		okay\@
	BREAKPOINT	"invalid a0 base"
okay\@:
	.endif
	.endm
	
	.macro	LOAD_D3_16_FROM_A1
	move.l	a1,d3
	sub.l	a6,d3
	.ifndef	RELEASE
	jpl		okay\@
	BREAKPOINT	"invalid a1 base"
okay\@:
	.endif
	.endm
	
	.macro	LOAD_D5D6_FROM_A0
	LOAD_D5_16_FROM_A0
	LOAD_D5D6_FROM_D5_16
	.endm

	.macro	LOAD_D3D4_FROM_A1
	LOAD_D3_16_FROM_A1
	LOAD_D3D4_FROM_D3_16
	.endm

	.macro	LOAD_A0_FROM_D5D6
	LOAD_D5_16_FROM_D5D6
	LOAD_A0_FROM_D5_16
	.endm


	.macro	LOAD_A1_FROM_D3D4
	LOAD_D3_16_FROM_D3D4
	lea	(a6,d3.l),a1
	.endm

	.macro	STORE_POINTER  src,dest
	move.l	d7,-(a7)
	move.l	\src,d7
	sub.l	a6,d7
	move.b	d7,\dest
	rol.w	#8,d7
	move.b	d7,1+\dest
	move.l	(a7)+,d7
	.endm

	.macro	LOAD_POINTER  src,dest
	move.l	d7,-(a7)
	moveq	#0,d7
	move.b	1+\src,d7
	rol.w	#8,d7
	move.b	\src,d7
	add.l	a6,d7
	move.l	d7,\dest
	move.l	(a7)+,d7
	.endm

	.macro	STORE_WORD  src,dest
	move.b	\src,\dest
	rol.w	#8,\src
	move.b	\src,1+\dest
	rol.w	#8,\src
	.endm

	.macro	LOAD_WORD  src,dest
	move.b	1+\src,\dest
	rol.w	#8,\dest
	move.b	\src,\dest
	.endm

