@-----------------------------------------------------------------------
@ Programa en Assembler ARM                                            | 
@ Universidad del Valle de Guatemala                                   | 
@ Autor: Walter Saldana  #19897										   |
@ Autor: Carlos Ráxtum   #19721                                        |
@ Autor: Eduardo Ramírez #19946                                        | 
@ 18 de mayo del 2020                                                  | 
@																	   | 
@ Aplicacion en assembler ARM para manejo de arreglos                  |
@                                                                      |
@Entradas:                                                             |
@	R0: Dirección de memoria al array                                  |
@	R1: Posición del elemento en el array solicitado                   |
@	R2: Cantidad de elementos del array solicitados.                   |
@Salida:                                                               |
@	R0: Elemento en la posición seleccionada del array seleccionado    | 
@		concatenado a n cantidad de elementos solicitados que le siguen|
@                                                                      |
@-----------------------------------------------------------------------

@@ INICIALIZACION ------------------------------------------------------
.text
.align 2 	@@ 2^2 Bytes (4 B = 32 b)
.global obtener_elemento

@@ CUERPO DEL PROGRAMA --------------------------------------------------

obtener_elemento:

	@@ Guardamos SP = LR (R13)
	stmfd sp!, {lr}

	ldr r0,=STRPEDIR
	bl puts
	ldr r0, =FORMS @ Se lee la cadena con formatoS
	ldr r1, =RES
	bl scanf @ compara si la letra corresponde a la palabra
	
	ldr r0, = cadena 
	ldrb r10, [r0]
	ldrb r11, [r0,#1] 
	sub r10, #0x30
	sub r10, #1 
	
	
	ldr r3, =LETRAS
	ldrb r9, [r3,r10] 
	
	mov r1,r9
	cmp r9, r11 
	
	beq correcto 
	ldr r0, =mensaje_noigual
	
	bl puts

	fin:
		ldr r0, =STR
		@@ DEVOLVER CONTROL AL PROGRAMA PRINCIPAL
		ldmfd sp!, {lr}		@@ Ahora R13 = SP
		bx lr
		

@@ AREA DE DATOS --------------------------------------------------------
.data

@ Mensages para interactuar con el usuario
STR: .asciz "                         "

@ Referencias a memorias que guardan datos ingresados por el usuario 
FORM: .asciz "%d"
OPC: .word 0
ARRAY: .word 0,0,0,0,0,0,0,0,0,0
