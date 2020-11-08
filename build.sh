# Compile into binary
"C:/Program Files/NASM/nasm" -f bin -o bootloader.bin bootloader.nasm

# Convert to runnable
dd conv=notrunc bs=512 count=1 if=bootloader.bin of=bootloader.flp