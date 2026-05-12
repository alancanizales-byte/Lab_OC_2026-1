%include "../../lib/pc_io.inc"

section .text
    global _start

_start:
    ; Mostrar mensaje
    mov eax, msgEntrada
    call printString

    ; Leer cadena
    mov eax, cadenaEntrada
    mov ebx, 64
    call readString

    ; Convertir ASCII a entero
    mov eax, cadenaEntrada
    call atoi

    ; EAX contiene entero con signo

    ; Convertir entero -> ASCII
    mov ebx, cadenaSalida
    mov ecx, 64
    call itoa

    ; Mostrar resultado
    mov eax, msgSalida
    call printString

    mov eax, cadenaSalida
    call printString

    mov eax, salto
    call printString

    ; Salir
    mov eax, 1
    xor ebx, ebx
    int 80h

atoi:
    push ebx
    push ecx
    push edx
    push esi

    mov esi, eax

    xor eax, eax        ; resultado = 0
    mov ecx, 1          ; signo = positivo

ignorarEspacios:
    mov bl, [esi]

    cmp bl, ' '
    je avanzarEspacio

    cmp bl, 9           
    je avanzarEspacio

    jmp revisarSigno

avanzarEspacio:
    inc esi
    jmp ignorarEspacios

revisarSigno:
    mov bl, [esi]

    cmp bl, '-'
    jne revisarMas

    mov ecx, -1
    inc esi
    jmp convertirDigitos

revisarMas:
    cmp bl, '+'
    jne convertirDigitos

    inc esi

convertirDigitos:
    mov bl, [esi]

    cmp bl, '0'
    jl finAtoi

    cmp bl, '9'
    jg finAtoi

    sub bl, '0'

    imul eax, eax, 10
    add eax, ebx

    inc esi
    jmp convertirDigitos

finAtoi:
    cmp ecx, -1
    jne salirAtoi

    neg eax

salirAtoi:
    pop esi
    pop edx
    pop ecx
    pop ebx
    ret

itoa:
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov esi, ebx        ; inicio buffer
    mov edi, ebx

    ; Verificar signo
    cmp eax, 0
    jge positivo

    mov byte [edi], '-'
    inc edi
    neg eax

positivo:
    ; Caso especial: 0
    cmp eax, 0
    jne convertirNumero

    mov byte [edi], '0'
    inc edi

    mov byte [edi], 0

    mov eax, esi
    jmp salirItoa

convertirNumero:
    xor ecx, ecx        ; contador

extraerDigitos:
    xor edx, edx
    mov ebx, 10

    div ebx

    add edx, '0'

    push edx
    inc ecx

    cmp eax, 0
    jne extraerDigitos

guardarDigitos:
    pop edx

    mov [edi], dl
    inc edi

    loop guardarDigitos

    mov byte [edi], 0

    mov eax, esi

salirItoa:
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    ret

printString:
    push eax
    push ebx
    push ecx
    push edx

    mov ecx, eax
    xor edx, edx

contador:
    cmp byte [ecx + edx], 0
    je imprimir

    inc edx
    jmp contador

imprimir:
    mov eax, 4
    mov ebx, 1
    int 80h

    pop edx
    pop ecx
    pop ebx
    pop eax
    ret

readString:
    push ecx
    push edx
    push esi

    mov esi, eax

    mov ecx, eax
    mov edx, ebx

    mov eax, 3
    mov ebx, 0
    int 80h

    ; Reemplazar ENTER por NULL
    xor ecx, ecx

buscarEnter:
    cmp byte [esi + ecx], 10
    je ponerNull

    cmp byte [esi + ecx], 0
    je finRead

    inc ecx
    jmp buscarEnter

ponerNull:
    mov byte [esi + ecx], 0

finRead:
    pop esi
    pop edx
    pop ecx
    ret

section .data
    msgEntrada db "Ingrese una cadena numerica: ",0
    msgSalida  db 10,"Numero convertido: ",0
    salto      db 10,0

section .bss
    cadenaEntrada resb 64
    cadenaSalida  resb 64