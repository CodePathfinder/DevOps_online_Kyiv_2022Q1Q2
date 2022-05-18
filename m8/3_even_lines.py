"""Write python program, which will ask file name. File should be read, and only even lines should be shown."""

filename = input("Enter filename or path to file: ")

try:
    file = open(filename, "r")
except FileNotFoundError:
    print(f"\n[ERROR]: FILE {filename} IS NOT AVAILABLE\n")
else:
    print()
    print(f"[SUCCESS]: PRINTING EVEN ROWS FROM FILE '{filename}' ...")
    print()
    for n, line in enumerate(file.readlines()):
        if n % 2 == 0:
            print(line)
    file.close()
    print()
