%include "../../lib/pc_io.inc"

section .text
    global _start

_start:
    ; Mostrar mensaje cantidad
    mov eax, msgCantidad
    call printString

    ; Leer cantidad
    mov eax, buffer
    mov ebx, 32
    call readString

    mov eax, buffer
    call atoi

    mov [cantidad], eax

    ; Capturar arreglo
    mov eax, arreglo
    mov ebx, [cantidad]
    call capturarArreglo

    ; Mostrar arreglo original
    mov eax, msgOriginal
    call printString

    mov eax, arreglo
    mov ebx, [cantidad]
    call mostrarArreglo

    ; Ordenar arreglo
    mov eax, arreglo
    mov ebx, [cantidad]
    call ordenarArreglo

    ; Mostrar arreglo ordenado
    mov eax, msgOrdenado
    call printString

    mov eax, arreglo
    mov ebx, [cantidad]
    call mostrarArreglo

    ; Salir
    mov eax, 1
    xor ebx, ebx
    int 80h

capturarArreglo:
    push ecx
    push edx
    push esi

    mov esi, eax
    mov ecx, ebx
    xor edx, edx

capturaLoop:
    cmp edx, ecx
    jge finCaptura

    mov eax, msgNumero
    call printString

    mov eax, buffer
    mov ebx, 32
    call readString

    mov eax, buffer
    call atoi

    mov [esi + edx*4], eax

    inc edx
    jmp capturaLoop

finCaptura:
    mov eax, esi

    pop esi
    pop edx
    pop ecx
    ret

mostrarArreglo:
    push ecx
    push edx
    push esi

    mov esi, eax
    mov ecx, ebx
    xor edx, edx

mostrarLoop:
    cmp edx, ecx
    jge finMostrar

    mov eax, [esi + edx*4]
    mov ebx, buffer
    call itoa

    mov eax, buffer
    call printString

    mov eax, espacio
    call printString

    inc edx
    jmp mostrarLoop

finMostrar:
    mov eax, salto
    call printString

    pop esi
    pop edx
    pop ecx
    ret

ordenarArreglo:
    push ecx
    push edx
    push esi
    push edi

    mov esi, eax          ; arreglo
    mov ecx, ebx          ; n

    xor edi, edi          ; i = 0

for_i:
    mov eax, ecx
    dec eax
    cmp edi, eax
    jge finOrdenar

    mov edx, edi          ; minimo = i

    mov ebx, edi
    inc ebx               ; j = i + 1

for_j:
    cmp ebx, ecx
    jge compararMinimo

    mov eax, [esi + ebx*4]
    mov eax, [esi + ebx*4]

    mov eax, [esi + ebx*4]
    mov ebp, [esi + edx*4]

    cmp eax, ebp
    jge continuarJ

    mov edx, ebx          ; minimo = j

continuarJ:
    inc ebx
    jmp for_j

compararMinimo:
    cmp edx, edi
    je siguienteI

    ; intercambio
    mov eax, [esi + edi*4]
    mov ebx, [esi + edx*4]

    mov [esi + edi*4], ebx
    mov [esi + edx*4], eax

siguienteI:
    inc edi
    jmp for_i

finOrdenar:
    mov eax, esi

    pop edi
    pop esi
    pop edx
    pop ecx
    ret

atoi:
    push ebx
    push ecx
    push edx
    push esi

    mov esi, eax
    xor eax, eax
    xor ebx, ebx

atoiLoop:
    mov bl, [esi]

    cmp bl, 10
    je atoiFin

    cmp bl, 0
    je atoiFin

    sub bl, '0'

    imul eax, eax, 10
    add eax, ebx

    inc esi
    jmp atoiLoop

atoiFin:
    pop esi
    pop edx
    pop ecx
    pop ebx
    ret

itoa:
    push eax
    push ebx
    push ecx
    push edx
    push esi

    mov esi, ebx
    mov ecx, 0
    mov edx, 0

    cmp eax, 0
    jne itoaLoop

    mov byte [esi], '0'
    mov byte [esi+1], 0
    jmp itoaFin

itoaLoop:
    mov edx, 0
    mov ebx, 10
    div ebx

    add edx, '0'

    push edx
    inc ecx

    cmp eax, 0
    jne itoaLoop

itoaPop:
    pop edx
    mov [esi], dl
    inc esi

    loop itoaPop

    mov byte [esi], 0

itoaFin:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret

printString:
    push eax
    push ebx
    push ecx
    push edx

    mov ecx, eax
    xor edx, edx

lenLoop:
    cmp byte [ecx + edx], 0
    je lenFin

    inc edx
    jmp lenLoop

lenFin:
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

    mov ecx, eax
    mov edx, ebx

    mov eax, 3
    mov ebx, 0
    int 80h

    pop edx
    pop ecx
    ret

section .data
    msgCantidad db "Cantidad de elementos (max 5): ",0
    msgNumero   db "Ingrese numero: ",0

    msgOriginal db 10,"Arreglo original:",10,0
    msgOrdenado db 10,"Arreglo ordenado:",10,0

    espacio db " ",0
    salto   db 10,0

section .bss
    buffer      resb 32
    arreglo     resd 5
    cantidad    resd 1