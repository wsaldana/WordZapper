@-----------------------------------------------------------------------
@ Programa en Assembler ARM                                            | 
@ Universidad del Valle de Guatemala                                   | 
@ Autor: Walter Saldana  #19897										   |
@ Autor: Carlos Ráxtum   #19721                                        |
@ Autor: Eduardo Ramírez #19946                                        | 
@ 18 de mayo del 2020                                                  | 
@																	   | 
@ Aplicacion en assembler ARM para sustituir un elemento de un array   |
@                                                                      |
@Entradas:                                                             |
@	R0: Dirección a memoria de la palabra a operar.                    |
@	R1: Carácter que se quiere reemplazar.                             |
@	R2 Carácter por el cual se quiere reemplazar.                      |
@	R3: Número de caracteres de la palabra.                            |
@Salidas: No tiene salidas.                                            |
@                                                                      |
@-----------------------------------------------------------------------

@@ INICIALIZACION ------------------------------------------------------
.text
.align 2 	@@ 2^2 Bytes (4 B = 32 b)
.global sustituir

@@ CUERPO DEL PROGRAMA --------------------------------------------------

sustituir:

	@@ Guardamos SP = LR (R13)
	stmfd sp!, {lr}

	@@ DO STUFF
	mul r1, #5 

	loop:
		cmp r3, #0
		beq fin
		@ldr r3, [r0, r1]
		@cmp r3, r1
		@strne r3, [=STR, r1]
		@streq r2, [=STR, r1]
		add r1, #5
		sub r3, #1
		b loop

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
