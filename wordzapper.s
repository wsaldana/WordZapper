@-----------------------------------------------------------------------
@ Programa en Assembler ARM                                            | 
@ Universidad del Valle de Guatemala                                   | 
@ Autor: Walter Saldana  #19897										   |
@ Autor: Carlos Ráxtum   #19721                                        |
@ Autor: Eduardo Ramírez #19946                                        | 
@ 18 de mayo del 2020                                                  | 
@																	   | 
@ Proyecto 3                                                           |
@ Juego en ARM                                                         |
@ Word Zapper														   |
@ El juego se trata de adivinar la letra faltante de las plabras       | 
@-----------------------------------------------------------------------

@@ INICIALIZACION ------------------------------------------------------
.text
.align 2 	@@ 2^2 Bytes (4 B = 32 b)
.global main
.type main,%function

@@ CUERPO DEL PROGRAMA --------------------------------------------------

main:
	@@ Guardamos SP = LR (R13)
	stmfd sp!, {lr}

	@@ DO STUFF

	/* Marcadores globales */
	mov r9,#0
	mov r10,#5

	/* Mostrar banner */
	ldr r0,=BANNER
	bl puts

	/* Mostrar instrucciones */
	ldr r0, =STRINST
	bl puts

	mostrar:
		@bl obtener_elemento
		ldr r0,=PALABRAS
		bl puts

	ingresar:
		/* Solicitar letra */
		ldr r0,=STRPEDIR
		bl puts

		ldr r0, =FORMS
		ldr r1, =RES
		bl scanf
		
		ldr r0, = RES 
		ldrb r7, [r0] 
		ldrb r6, [r0,#1] 
		sub r7, #48
		sub r7, #1 
		
		ldr r3, =LETRAS
		ldrb r8, [r3,r7] 
		mov r1,r8
		cmp r8, r6 
		beq correcto
		b incorrecto
	
	/* Etiqueta para mostrar que el resultado es correcto */
	correcto:
		ldr r0, =STRCORRECTO
		bl puts
		mov r0,r7
		add r10, #1
		add r9, #1
		cmp r9, #5
		bne mostrar
		ldr r0,=STRGANO
		bl puts
		b fin

	/* Etiqueta para mostrar que el resultado es incorrecto */
	incorrecto:
		ldr r0, =STRINCORRECTO
		bl puts
		subs r10,#1
		bne mostrar
		ldr r0,=STRPERDIO
		bl puts
		b fin


	@@ FIN DEL PROGRAMA -----------------------------------------------------
	fin:
		ldr r0, =STRFIN  			/* --- Mensaje de despedida */
		bl puts


	@@ DEVOLVER CONTROL AL SISTEMA OPERATIVO
	ldmfd sp!, {lr}		@@ Ahora R13 = SP
	bx lr
		

@@ AREA DE DATOS --------------------------------------------------------
.data
.align 2

@ Mensages para interactuar con el usuario
BANNER: .asciz "--------------------\n********************\n --- WORD ZAPPER --- \n Assembly ARM \n UVG \n********************\n--------------------\n"
STRINST: .asciz "Destruye las palabras al completarlas!!! Indica el numero de la palabra seguido del caracter faltante. EJ: 1a \n"
STRPEDIR: .asciz "\nIngrese la(s) letra(s) faltante(s): "
STRGANO: .asciz "Haz Ganado!!!!"
STRPERDIO: .asciz "Haz Perdidio :((("
STRFIN: .asciz "Nos vemos pronto!!\n"
STRCORRECTO: .asciz "Correcto! \n"
STRINCORRECTO: .asciz "Incorrecto! \n"
CHAR: .asciz "%s"
PALABRAS: .asciz "1.anot_","2.ga_ta","3._ielo","4.libr_","5.ba_co"
LETRAS: .byte 'a', 'i', 'c', 'a','n'

@ Referencias a memorias que guardan datos ingresados por el usuario 
FORM: .asciz "%d"
FORMS: .asciz "%s"
RES: .asciz "  "

