strcmp:

    push rbp
    mov rbp, rsp
    sub rsp, 0x10

    mov rsi, rcx
    mov rdi, rdx

    xor rax, rax
    xor rcx, rcx
    xor rdx, rdx

strcmp_loop:

    mov al, [rsi+rdx]
    mov cl, [rdi+rdx]

    mov [rbp-0x08], cl
    or [rbp-0x08], al
    jz strcmp_end   ; They're equal if both bytes are null

    sub ax, cx
    jnz strcmp_sign_extend  ; if they're not equal, just exit with whatever is in rax already

    ; They must be equal so far so loop around
    inc rdx
    jmp strcmp_loop

strcmp_sign_extend:

    cwde        ; Sign extend ax => eax
    cdqe        ; Sign extend eax => rax

strcmp_end:

    leave
    ret