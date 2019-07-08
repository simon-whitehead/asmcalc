
; read_line(char* rcx, int rdx)
read_line:
    push rbp
    mov rbp,rsp
    sub rsp,0x30

    ; Store RCX and RDX in the shadow space
    mov [rbp+0x10],rcx
    mov [rbp+0x18],rdx

    mov rcx,STD_INPUT_HANDLE	; Get handle to StdIn
    call GetStdHandle

    mov rcx,rax			    ; hFile
    mov rdx,[rbp+0x10]		; lpBuffer
    mov r8,[rbp+0x18]		; nNumberOfBytesToRead
    lea r9,[rbp-0x08]		; lpNumberOfBytesRead

    mov qword [rbp-0x08],0	; lpOverlapped
    call ReadFile

    mov rax,[rbp-0x08]		; Put the number of bytes read in to rax

    sub rax,0x02            ; Our "bytes read" includes the carriage return and line feed - so lets skip those

    mov rdx,[rbp+0x10]      ; Load the buffer back into rdx
    mov byte [rdx+rax],0x00 ; Null terminate the string after the main command (e.g, "exit\r\n" becomes "exit")

    leave
    ret

; write_line(char* rcx, int rdx)
write_line:
    push rbp
    mov rbp,rsp
    sub rsp,0x30
    
    ; Store RCX and RDX in the shadow space
    mov [rbp+0x10],rcx
    mov [rbp+0x18],rdx

    mov rcx,STD_OUTPUT_HANDLE	; Get handle to StdOut
    call GetStdHandle

    mov rcx,rax			    ; hFile
    mov rdx,[rbp+0x10]		; lpBuffer
    mov r8,[rbp+0x18]		; nNumberOfBytesToRead
    lea r9,[rbp-0x08]		; lpNumberOfBytesRead

    mov qword [rbp-0x08],0	; lpOverlapped
    call WriteFile

    leave
    ret