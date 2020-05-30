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

	@@ DO STUFF
	mul r1, #5 

	concatenar:
		cmp r2, #0
		beq fin
		ldr r3, [r0, r1]
		str r3, [=STR, r1]
		add r1, #5
		sub r2, #1
		b concatenar

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
