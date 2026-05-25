global set_bit
global get_bit

section .text

set_bit:
    push ebp
    mov ebp, esp

    mov eax,[ebp+8]      
    mov ecx,[ebp+12]     

    mov edx,1
    shl edx,cl

    or byte [eax],dl

    mov esp,ebp
    pop ebp

    ret

get_bit:
    push ebp
    mov ebp,esp

    movzx eax,byte [ebp+8]

    mov ecx,[ebp+12]

    shr eax,cl

    and eax,1

    mov esp,ebp
    pop ebp

    ret