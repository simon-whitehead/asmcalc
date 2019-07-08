section .data

    HEAP_ZERO_MEMORY    equ 0x08

section .text

; malloc(void* buffer)
malloc:

    sub rsp,0x28	; 32 bytes for HeapAlloc + 8 for the return address makes 40, aligned to 48

    call GetProcessHeap

    mov r8,rcx			        ; dwBytes
    mov rcx,rax                 ; hHeap
    mov rdx,HEAP_ZERO_MEMORY	; dwFlags
    call HeapAlloc

    add rsp,0x28

    ret

; dealloc(void* buffer)
dealloc:

    sub rsp,0x28

    call GetProcessHeap

    mov rcx,rax
    mov r8,rcx
    xor rdx,rdx
    call HeapFree

    add rsp,0x28

    ret
