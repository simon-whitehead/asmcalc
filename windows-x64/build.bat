nasm -f win64 asmcalc.asm -o build/asmcalc.obj
GoLink /console /entry main build/asmcalc.obj kernel32.dll /fo build/asmcalc.exe