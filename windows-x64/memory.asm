section .data

    HEAP_ZERO_MEMORY    equ 0x08

section .text

; malloc(int rcx)
malloc:

    sub rsp, 0x28	; 32 bytes for HeapAlloc + 8 for the return address makes 40, aligned to 48

    mov [rsp+0x10], rcx ; spill rcx

    call GetProcessHeap

    mov rcx, rax                ; hHeap
    mov rdx, HEAP_ZERO_MEMORY	; dwFlags
    mov r8, [rsp+0x10]          ; dwBytes via spilled rcx
    call HeapAlloc

    add rsp, 0x28

    ret

; dealloc(void* buffer)
dealloc:

    sub rsp, 0x28

    mov [rsp+0x10], rcx ; spill rcx

    call GetProcessHeap

    mov rcx, rax        ; hHeap
    xor rdx, rdx        ; dwFlags
    mov r8, [rsp+0x10]  ; lpMem
    call HeapFree

    add rsp, 0x28

    ret
