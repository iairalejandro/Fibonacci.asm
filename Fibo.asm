# SECCION DE INSTRUCCIONES (.text)
.text
.globl __start

__start:
    # Solicita al usuario que ingrese el número de términos
    la $a0, msg_prompt
    li $v0, 4
    syscall               # Imprime "Ingresar el número de términos:"
    
    li $v0, 5
    syscall               # Lee la entrada del usuario y la guarda en $v0
    move $t8, $v0         # Almacena el valor ingresado en $t8 (n)

    # Inicializa los primeros valores de Fibonacci
    li $t0, 0             # t0 = 0 (primer valor de Fibonacci)
    li $t1, 1             # t1 = 1 (segundo valor de Fibonacci)

    # Imprime mensaje de inicio de serie
    la $a0, msg_intro
    li $v0, 4
    syscall               # Imprime "La serie Fibonacci de "
    
    move $a0, $t8
    li $v0, 1
    syscall               # Imprime el valor de n
    
    la $a0, msg_terms
    li $v0, 4
    syscall               # Imprime " términos es: "
    
    # Imprime los primeros dos valores de Fibonacci (0 y 1)
    move $a0, $t0
    li $v0, 1
    syscall               # Imprime 0

    la $a0, separator
    li $v0, 4
    syscall               # Imprime ", "

    move $a0, $t1
    li $v0, 1
    syscall               # Imprime 1

    la $a0, separator
    li $v0, 4
    syscall               # Imprime ", "

    # Itera para calcular y mostrar el resto de los términos
    li $t4, 2             # Contador de términos, empieza en 2

loop:
    # Calcula el siguiente término de Fibonacci
    add $t2, $t0, $t1     # t2 = t0 + t1
    
    # Imprime el valor actual de Fibonacci
    move $a0, $t2
    li $v0, 1
    syscall               # Imprime el término de Fibonacci

    # Verifica si ha alcanzado el número de términos deseado
    beq $t4, $t8, end     # Si contador == n, salir del bucle

    la $a0, separator
    li $v0, 4
    syscall               # Imprime ", "

    # Actualiza valores para el siguiente término de Fibonacci
    addi $t4, $t4, 1      # Incrementa el contador
    move $t0, $t1         # t0 = t1
    move $t1, $t2         # t1 = t2

    j loop                # Repite el bucle

end:
    # Fin de la serie, imprime nueva línea y termina
    la $a0, newline
    li $v0, 4
    syscall               # Imprime nueva línea

    li $v0, 10
    syscall               # Salir del programa

# SECCION DE VARIABLES EN MEMORIA (.data)
.data
msg_prompt: .asciiz "Ingresar el número de términos: "
msg_intro:  .asciiz "La serie Fibonacci de "
msg_terms:  .asciiz " términos es: "
separator:  .asciiz ", "
newline:    .asciiz "\n"
