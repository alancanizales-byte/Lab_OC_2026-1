%include "../../lib/pc_io.inc"

section .text
    global _start

_start:
    mov edx, msg        ; mensaje para pedir cadena
    call puts

    mov ax, 64          ; capturar cadena
    mov edx, cad
    call capturar

    mov al, 0x0A        ; salto de linea
    call putchar

    mov edx, original       ; mostrar cadena original
    call puts
    mov edx, cad
    call puts

    mov edx, cad            ; convertir a mayusculas
    call mayusculas

    mov edx, mayus          ; mostrar cadena en mayusculas
    call puts
    mov edx, cad
    call puts

    mov edx, cad            ; convertir a minusculas
    call minusculas

    mov edx, minus          ; mostrar cadena en minusculas
    call puts
    mov edx, cad
    call puts

    mov al, 0x0A            ; salto de linea
    call putchar

    ; Salida del programa
    mov eax, 1
    int 0x80

capturar:
    push ax
    push bx
    push cx
    push dx

    mov cx, ax
    dec cx 
    xor bx, bx             

.ciclo:
    call getch

    cmp al, 0x0A        ; ¿es enter?
    je .fin

    cmp al, 0x08        ; ¿es backspace?
    je .borrar

    cmp al, 0x7F         ; ¿es delete?
    je .borrar

    cmp cx, 0             ; ¿es espacio?
    je .ciclo

    call putchar        ; mostrar caracter
    mov [edx], al

    inc edx              ; avanzar puntero
    inc bx               ; incrementar longitud
    dec cx               ; reducir espacio disponible
    jmp .ciclo

.borrar:
    cmp bx, 0
    je .ciclo

    dec edx
    dec bx
    inc cx

    mov al, 0x08
    call putchar
    mov al, ' '
    call putchar
    mov al, 0x08
    call putchar

    jmp .ciclo

.fin:
    mov byte [edx], 0   

    pop dx
    pop cx
    pop bx
    pop ax
    ret

mayusculas:
    push ax
    push dx

.recorrer:
    mov al, [edx]

    cmp al, 0
    je .fin

    cmp al, 'a'
    jb .sig

    cmp al, 'z'
    ja .sig

    sub al, 32
    mov [edx], al

.sig:
    inc edx
    jmp .recorrer

.fin:
    pop dx
    pop ax
    ret

minusculas:
    push ax
    push dx

.recorrer:
    mov al, [edx]

    cmp al, 0
    je .fin

    cmp al, 'A'
    jb .sig

    cmp al, 'Z'
    ja .sig

    add al, 32
    mov [edx], al

.sig:
    inc edx
    jmp .recorrer

.fin:
    pop dx
    pop ax
    ret

section .data
    msg db "Ingresa una cadena: ",0
    original db 0x0A,"Original: ",0
    mayus db 0x0A,"Mayusculas: ",0
    minus db 0x0A,"Minusculas: ",0

section .bss
    cad resb 64
