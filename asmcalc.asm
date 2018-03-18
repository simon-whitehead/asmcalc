global main

section .text

main:

    sub rsp,0x08
    xor eax,eax
    add rsp,0x08 ; thanks Michael Petch for pointing out this omission

    ret