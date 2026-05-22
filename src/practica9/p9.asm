%include "../../lib/pc_io.inc"

global maximo
global minimo
global sumatoria

section .data

%macro FOR 4
    push ecx
    push edx

    mov ecx,%1
    mov edx,%2

.%4:
    call %3
    add edx,4
    loop .%4

    pop edx
    pop ecx
%endmacro

section .text

maximo:
    push ebp
    mov ebp,esp

    mov esi,[ebp+8]     
    mov ecx,[ebp+12]    

    mov eax,[esi]       

    dec ecx
    add esi,4

    FOR ecx,esi,comparar_max,max

    mov esp, ebp
    pop ebp
    ret

comparar_max:
    mov ebx,[edx]

    cmp ebx,eax
    jle salir_max

    mov eax,ebx

salir_max:
    ret

minimo:
    push ebp
    mov ebp,esp

    mov esi,[ebp+8]
    mov ecx,[ebp+12]

    mov eax,[esi]

    dec ecx
    add esi,4

    FOR ecx,esi,comparar_min,min

    mov esp, ebp
    pop ebp
    ret


comparar_min:
    mov ebx,[edx]

    cmp ebx,eax
    jge salir_min

    mov eax,ebx

salir_min:
    ret

sumatoria:
    push ebp
    mov ebp,esp

    mov esi,[ebp+8]
    mov ecx,[ebp+12]

    xor eax,eax

    FOR ecx,esi,sumar,suma

    mov esp, ebp
    pop ebp
    ret

sumar:
    add eax,[edx]
    ret