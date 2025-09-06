import ctypes

msvcrt = ctypes.CDLL("msvcrt.dll")
msvcrt.printf(b"Hello from msvcrt.dll!\n")
