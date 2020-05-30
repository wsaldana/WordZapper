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
		mov r0, #1				@monitor
		ldr r1, =PALABRAS		@Dir del mensaje
		mov r2, #49			@longitud de cadena en caracteres
		mov r7, #4				@write
		swi 0

	ingresar:
		/* Solicitar letra */
		ldr r0,=STRPEDIR
		bl puts

		/* Capturar valor de letra ingresada por el usuario */
		ldr r0, =FORMS
		ldr r1, =RES
		bl scanf
		
		/* Mover a registros el nuemro y letra que ingresa el usuario */
		ldr r0, = RES 
		ldrb r7, [r0] 
		ldrb r6, [r0,#1]
		/* Conversion ascii a numero */
		sub r7, #49
		
		/* Comparar respuesta correcta con la del usuario */
		ldr r3, =LETRAS
		/* offset que indica el numero de la letra */
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

STRINST: .asciz "Destruye las palabras al completarlas!!! Indica el numero de la palabra seguido del caracter faltante. EJ: 1a \n"
STRPEDIR: .asciz "\nIngrese la(s) letra(s) faltante(s): "
STRGANO: .asciz "Haz Ganado!!!!"
STRPERDIO: .asciz "Haz Perdidio :((("
STRFIN: .asciz "Nos vemos pronto!!\n"
STRCORRECTO: .asciz "Correcto! \n"
STRINCORRECTO: .asciz "Incorrecto! \n"
CHAR: .asciz "%s"
PALABRAS: .asciz "1.anot_  ","2.ga_ta  ","3._ielo  ","4.libr_  ","5.ba_co  "
LETRAS: .byte 'a', 'i', 'c', 'a','n'
RESPUESTAS: .asciz "anota","gaita","cielo","libra","banco"
ENTER: .asciz "\n"

@ Referencias a memorias que guardan datos ingresados por el usuario 
FORM: .asciz "%d"
FORMS: .asciz "%s"
RES: .asciz "  "

BANNER:.asciz "
----------------------------------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////////////////////////////

 * - >              __                        __                        __              < - *                             
 * - >            _|  |_                    _|  |_                    _|  |_            < - *                               
 * - >          _|      |_                _|      |_                _|      |_          < - *                           
 * - >         |  _    _  |              |  _    _  |              |  _    _  |         < - *                         
 * - >         | |_|  |_| |              | |_|  |_| |              | |_|  |_| |         < - *                             
 * - >      _  |  _    _  |  _        _  |  _    _  |  _        _  |  _    _  |  _      < - *                                
 * - >     |_|_|_| |__| |_|_|_|      |_|_|_| |__| |_|_|_|      |_|_|_| |__| |_|_|_|     < - *                              
 * - >       |_|_        _|_|          |_|_        _|_|          |_|_        _|_|       < - *                        
 * - >         |_|      |_|              |_|      |_|              |_|      |_|         < - *
 
 _     _  _______  ______    ______     _______  _______  _______  _______  _______  ______   
| | _ | ||       ||    _ |  |      |   |       ||   _   ||       ||       ||       ||    _ |  
| || || ||   _   ||   | ||  |  _    |  |____   ||  |_|  ||    _  ||    _  ||    ___||   | ||  
|       ||  | |  ||   |_||_ | | |   |   ____|  ||       ||   |_| ||   |_| ||   |___ |   |_||_ 
|       ||  |_|  ||    __  || |_|   |  | ______||       ||    ___||    ___||    ___||    __  |
|   _   ||       ||   |  | ||       |  | |_____ |   _   ||   |    |   |    |   |___ |   |  | |
|__| |__||_______||___|  |_||______|   |_______||__| |__||___|    |___|    |_______||___|  |_|

//////////////////////////////////////////////////////////////////////////////////////////////
----------------------------------------------------------------------------------------------

"