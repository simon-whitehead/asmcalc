section .data

    valid_chars             db "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890*+-/^ ()", 0

    err_invalid_char        db "err: invalid char", 10, 0
    err_invalid_char.len    equ $-err_invalid_char-0x01

section .text

; "token" layout is:
; +----------------+-----------------+
; | type (8 bytes) | value (8 bytes) |
; +----------------+-----------------+
; although the type doesn't need to be 8 whole bytes, we will only
; be using 1 byte worth of space really but to keep it byte aligned
; we'll expect all 8

tokenise:

    push rbp
    mov rbp, rsp

    push rsi

    sub rsp, 0x28

    mov [rbp+0x10], rcx ; input buffer

    ; allocate enough memory to return 100 tokens
    mov rcx, 0x10 * 0x64
    call malloc

    xor rcx, rcx
    mov rsi, [rbp+0x10]
    
tokenise_loop:
    ; reached the end?
    cmp byte [rsi+rcx], 0
    je tokenise_end

    mov [rbp+0x18], rcx
    ; check that this is at least within the character 
    ; range of the ASCII table we care about
    mov rcx, [rsi+rcx]
    call is_valid_char
    cmp rax, 0x00
    je tokenise_invalid_char

    mov rcx, [rbp+0x18]

    inc rcx

    jmp tokenise_loop

tokenise_invalid_char:

    mov rcx, err_invalid_char
    mov rdx, err_invalid_char.len
    call write_line

tokenise_end:

    add rsp, 0x28

    pop rsi

    leave
    ret

is_valid_char:

    push rbp
    mov rbp, rsp

    push rsi

    mov rsi, valid_chars
    mov rdx, rcx
    xor rcx, rcx
    xor rax, rax

is_valid_char_loop:

    cmp byte [rsi+rcx], dl
    je is_valid_char_valid
    cmp byte [rsi+rcx], 0x00
    je is_valid_char_end

    inc rcx

    jmp is_valid_char_loop

is_valid_char_valid:

    mov rax, 0x01

is_valid_char_end:

    pop rsi

    leave
    ret