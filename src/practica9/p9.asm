%include "../../lib/pc_io.inc"

global maximo
global minimo
global sumatoria

section .text

%macro FOR 2
%%inicio:
    call %1
    add esi,4
    loop %%inicio
%endmacro

maximo:
    push ebp
    mov ebp,esp

    push esi
    push ebx

    mov esi,[ebp+8]
    mov ecx,[ebp+12]

    mov eax,[esi]

    dec ecx
    jz .finmax

    add esi,4

    FOR comparar_max,max

.finmax:
    pop ebx
    pop esi

    mov esp,ebp
    pop ebp
    ret

comparar_max:
    mov ebx,[esi]

    cmp ebx,eax
    jle .salir

    mov eax,ebx

.salir:
    ret

minimo:
    push ebp
    mov ebp,esp

    push esi
    push ebx

    mov esi,[ebp+8]
    mov ecx,[ebp+12]

    mov eax,[esi]

    dec ecx
    jz .finmin

    add esi,4

    FOR comparar_min,min

.finmin:
    pop ebx
    pop esi

    mov esp,ebp
    pop ebp
    ret

comparar_min:
    mov ebx,[esi]

    cmp ebx,eax
    jge .salir

    mov eax,ebx

.salir:
    ret

sumatoria:
    push ebp
    mov ebp,esp

    push esi

    mov esi,[ebp+8]
    mov ecx,[ebp+12]

    xor eax,eax

    FOR sumar,suma

    pop esi

    mov esp,ebp
    pop ebp
    ret

sumar:
    add eax,[esi]
    ret