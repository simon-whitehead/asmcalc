; Simon Whitehead, 2015
; ---------------------
;
; 1. Hello world
;
;    This program prints "Hello world!" to the Console
;    then exits

%include "io.asm"
%include "memory.asm"
%include "rpncalc.asm"
%include "strcmp.asm"
%include "tokenise.asm"
%include "winapi.asm"

global main

section .data

    STD_INPUT_HANDLE    equ -10
    STD_OUTPUT_HANDLE   equ -11

    INPUT_BUFFER_SIZE   equ 1024

    cursor              db "asmcalc>", 0
    cursor.len          equ $-cursor
    test_cmd            db "-- TESTING --", 10, 0
    test_cmd.len        equ $-test_cmd

    ; Commands
    EXIT_COMMAND        db "exit", 0
    TEST_COMMAND        db "?test?", 0

section .bss

    empty           resd 1
    CONSOLE_HANDLE  resq 1

    input_buffer    resb INPUT_BUFFER_SIZE

section .text

main:

    push rbp
    mov rbp, rsp
    sub rsp, 0x30

    call input_loop ; main loop

    leave
    ret

input_loop:

    call zero_input_buffer

    ; display the input cursor 
    mov rcx, cursor
    mov rdx, cursor.len
    call write_line

    ; read the input
    mov rcx, input_buffer
    mov rdx, INPUT_BUFFER_SIZE
    call read_line

    ; switch (input_buffer)

    ; case "exit"
    mov rcx, input_buffer
    mov rdx, EXIT_COMMAND 
    call strcmp
    test rax, rax
    je end

    ; case "?test?"
    mov rcx, input_buffer
    mov rdx, TEST_COMMAND 
    call strcmp
    test rax, rax
    je test_command

    ; let's try to parse the rest
    mov rcx, input_buffer
    call tokenise
    mov rcx, rax
    call calculate_rpn

input_loop_end:

    jmp input_loop

end:
    mov rcx, 0x00
    call ExitProcess

    ret

; test_command() - prints the test command
test_command:
    mov rcx, test_cmd
    mov rdx, test_cmd.len-0x01
    call write_line

    jmp input_loop_end

zero_input_buffer:

    cld
    mov rdi, input_buffer
    mov rcx, INPUT_BUFFER_SIZE

    xor rax, rax
    rep stosb

    ret