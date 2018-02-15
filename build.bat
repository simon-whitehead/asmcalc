nasm -f win64 asmcalc.asm -o build/asmcalc.obj
GoLink /console /entry main build/asmcalc.obj /fo build/asmcalc.exe