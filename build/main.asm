;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.6.0 #16555 (Linux)
;--------------------------------------------------------
	.module main
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _set_bkg_palette
	.globl _fill_bkg_rect
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _solid_tile
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute ram data
;--------------------------------------------------------
	.area _DABS (ABS)
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/main.c:10: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-8
;src/main.c:11: set_bkg_data(0, 1, solid_tile);
	ld	de, #_solid_tile
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_bkg_data
	add	sp, #4
;src/main.c:12: fill_bkg_rect(0, 0, 20, 18, 0);
	xor	a, a
	ld	h, a
	ld	l, #0x12
	push	hl
	ld	a, #0x14
	push	af
	inc	sp
	xor	a, a
	rrca
	push	af
	call	_fill_bkg_rect
	add	sp, #5
;src/main.c:14: palette_color_t pal[4] = {
	ldhl	sp,	#0
	ld	a, #0xe0
	ld	(hl+), a
	ld	(hl), #0x7d
	ld	hl, #2
	add	hl, sp
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	ld	hl, #4
	add	hl, sp
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
	ld	hl, #6
	add	hl, sp
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;src/main.c:20: set_bkg_palette(0, 1, pal);
	ld	hl, #0
	add	hl, sp
	push	hl
	xor	a, a
	inc	a
	push	af
	call	_set_bkg_palette
	add	sp, #4
;src/main.c:22: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/main.c:23: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/main.c:25: while(1) {
00102$:
;src/main.c:26: wait_vbl_done();
	call	_wait_vbl_done
	jr	00102$
;src/main.c:28: }
	add	sp, #8
	ret
_solid_tile:
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
