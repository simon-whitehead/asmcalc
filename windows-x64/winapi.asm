; Windows APIs

; GetStdHandle
; ------------
; HANDLE WINAPI GetStdHandle(
;     _In_ DWORD nStdHandle
; ); 
extern GetStdHandle

; ReadFile
; ------------
; BOOL WINAPI ReadFile(
;   _In_        HANDLE       hFile,
;   _Out_       LPVOID       lpBuffer,
;   _In_        DWORD        nNumberOfBytesToRead,
;   _Out_opt_   LPDWORD      lpNumberOfBytesRead,
;   _Inout_opt_ LPOVERLAPPED lpOverlapped
; );
extern ReadFile

; WriteFile
; ------------
; BOOL WINAPI WriteFile(
;   _In_        HANDLE       hFile,
;   _In_        LPCVOID      lpBuffer,
;   _In_        DWORD        nNumberOfBytesToWrite,
;   _Out_opt_   LPDWORD      lpNumberOfBytesWritten,
;   _Inout_opt_ LPOVERLAPPED lpOverlapped
; );
extern WriteFile

; GetProcessHeap
; -----------
; HANDLE WINAPI GetProcessHeap(void);
extern GetProcessHeap

; HeapAlloc
; -----------
; LPVOID WINAPI HeapAlloc(
;   _In_ HANDLE hHeap,
;   _In_ DWORD  dwFlags,
;   _In_ SIZE_T dwBytes
; );
extern HeapAlloc

; HeapFree
; -----------
; BOOL WINAPI HeapFree(
;   _In_ HANDLE hHeap,
;   _In_ DWORD  dwFlags,
;   _In_ LPVOID lpMem
; );
extern HeapFree

; ExitProcess
; -----------
; VOID WINAPI ExitProcess(
;     _In_ UINT uExitCode
; );
extern ExitProcess