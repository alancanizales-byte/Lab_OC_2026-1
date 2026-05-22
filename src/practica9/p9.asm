%include "../../lib/pc_io.inc"

global maximo
global minimo
global sumatoria

section .text

%macro FOR 1
%%ciclo:
    call %1
    add esi,4
    loop %%ciclo
%endmacro

maximo:
    push ebp
    mov ebp,esp

    push ebx
    push esi

    mov esi,[ebp+8]
    mov ecx,[ebp+12]

    mov eax,[esi]

    dec ecx
    jz .fin

    add esi,4

    FOR comparar_max

.fin:
    pop esi
    pop ebx

    mov esp,ebp
    pop ebp
    ret

comparar_max:
    push ebx
    mov ebx,[esi]

    cmp ebx,eax
    jle .salir

    mov eax,ebx

.salir:
    pop ebx
    ret

minimo:
    push ebp
    mov ebp,esp

    push ebx
    push esi

    mov esi,[ebp+8]
    mov ecx,[ebp+12]

    mov eax,[esi]

    dec ecx
    jz .fin

    add esi,4

    FOR comparar_min

.fin:
    pop esi
    pop ebx

    mov esp,ebp
    pop ebp
    ret

comparar_min:
    push ebx
    mov ebx,[esi]

    cmp ebx,eax
    jge .salir

    mov eax,ebx

.salir:
    pop ebx
    ret

sumatoria:
    push ebp
    mov ebp,esp

    push esi
    push ecx

    mov esi,[ebp+8]
    mov ecx,[ebp+12]

    xor eax,eax

.ciclo:
    add eax,[esi]
    add esi,4
    loop .ciclo

    pop ecx
    pop esi

    mov esp,ebp
    pop ebp
    ret