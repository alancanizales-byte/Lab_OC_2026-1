%include "../../lib/pc_io.inc"

section .text
    global _start

_start:
    ; Mostrar mensaje de entrada
    mov eax, 4
    mov ebx, 1
    mov ecx, msgEntrada
    mov edx, lenEntrada
    int 80h

    ; Leer cadena
    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 63              ; dejamos espacio para \0
    int 80h

    ; Reemplazar ENTER por NULL
    mov esi, buffer

buscar_fin:
    cmp byte [esi], 10       ; salto de línea
    je poner_null
    cmp byte [esi], 0
    je convertir
    inc esi
    jmp buscar_fin

poner_null:
    mov byte [esi], 0

convertir:
    push buffer
    call ATOI
    add esp, 4

    mov [numero], eax

    push dword 64
    push salida
    push dword [numero]
    call ITOA
    add esp, 12

    ; Mostrar mensaje de salida
    mov eax, 4
    mov ebx, 1
    mov ecx, msgSalida
    mov edx, lenSalida
    int 80h

    ; Mostrar cadena convertida
    mov eax, 4
    mov ebx, 1
    mov ecx, salida
    call strlen
    mov edx, eax
    mov eax, 4
    int 80h

    ; salto de línea
    mov eax, 4
    mov ebx, 1
    mov ecx, salto
    mov edx, 1
    int 80h

    ; salir
    mov eax, 1
    xor ebx, ebx
    int 80h

ATOI:
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    push edx
    push esi

    mov esi, [ebp+8]
    xor eax, eax          ; resultado = 0
    mov ebx, 1            ; signo = +1

; Ignorar espacios y tabs
skip_spaces:
    mov cl, [esi]
    cmp cl, ' '
    je avanzar
    cmp cl, 9             ; tab
    je avanzar
    jmp check_sign

avanzar:
    inc esi
    jmp skip_spaces

; Revisar signo
check_sign:
    cmp byte [esi], '-'
    jne check_plus
    mov ebx, -1
    inc esi
    jmp convertir_digitos

check_plus:
    cmp byte [esi], '+'
    jne convertir_digitos
    inc esi

; Convertir dígitos
convertir_digitos:
    mov cl, [esi]

    cmp cl, '0'
    jl fin_atoi
    cmp cl, '9'
    jg fin_atoi

    ; eax = eax * 10
    imul eax, eax, 10

    ; sumar dígito
    sub cl, '0'
    movzx edx, cl
    add eax, edx

    inc esi
    jmp convertir_digitos

fin_atoi:
    cmp ebx, 1
    je salir_atoi
    neg eax

salir_atoi:
    pop esi
    pop edx
    pop ecx
    pop ebx
    mov esp, ebp
    pop ebp
    ret

ITOA:
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov eax, [ebp+8]      ; número
    mov edi, [ebp+12]     ; destino

    mov esi, edi          ; guardar inicio

    ; verificar signo
    cmp eax, 0
    jge positivo

    mov byte [edi], '-'
    inc edi
    neg eax

positivo:
    ; caso especial: número = 0
    cmp eax, 0
    jne convertir_itoa

    mov byte [edi], '0'
    inc edi
    mov byte [edi], 0
    mov eax, esi
    jmp fin_itoa

; Guardar dígitos invertidos en stack
convertir_itoa:
    xor ecx, ecx          ; contador

loop_div:
    xor edx, edx
    mov ebx, 10
    div ebx               ; eax / 10

    add dl, '0'
    push edx
    inc ecx

    cmp eax, 0
    jne loop_div

; Sacar en orden correcto
escribir:
    cmp ecx, 0
    je terminar

    pop edx
    mov [edi], dl
    inc edi
    dec ecx
    jmp escribir

terminar:
    mov byte [edi], 0
    mov eax, esi

fin_itoa:
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    mov esp, ebp
    pop ebp
    ret

strlen:
    xor eax, eax

strlen_loop:
    cmp byte [ecx + eax], 0
    je strlen_fin
    inc eax
    jmp strlen_loop

strlen_fin:
    ret

section .data
    msgEntrada db "Ingrese una cadena numerica: ", 0
    lenEntrada equ $ - msgEntrada

    msgSalida db "Numero convertido: ", 0
    lenSalida equ $ - msgSalida

    salto db 10

section .bss
    buffer      resb 64       ; entrada del usuario
    salida      resb 64       ; salida para ITOA
    numero      resd 1