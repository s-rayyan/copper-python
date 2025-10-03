# CopperPython — Securly Python Bypass  

A tool to run Python on restricted school computers without using `.exe` files, useful where executables are blocked.  

---

## Download & Setup  

1. Open powershell and run `Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass`
2. Download the setup script.  
3. Open your downloads in your browser (`Ctrl+J`).  
4. If warned that the file “could harm your device,” click **Keep**.  
5. Click **Open File**.  
6. A Command Prompt window will open and run automatically — **do not close it** until it finishes.  
7. Once closed, open PowerShell — now you can use the `python` command.  

---

## About CopperPython  

This is **IronPython-based**, not standard CPython. Many core features work, but some are missing. For example, `print()` and `input()` are manually implemented and limited.  

---

## Disclaimer  

Use at your own risk. I am not responsible for any consequences from your school or district. As a fellow student, here’s a useful excuse I’ve used: *"It’s just a coding thing."*  

---

## Key Differences from CPython  

- **C# module support** in CopperPython.  
- Missing some standard Python features.  

### Print Function  

Still in development. Works differently: no `end` parameter, no optional arguments, and requires at least one parameter.  

**Works:**  
- `print("Hello World")`  
- `print("Hello" + " World")`  
- `print(3)`  
- `print(3.14)`  
- `print("")`  

**Doesn’t work:**  
- `print()`  
- `print("Hello", "World")`  
- `print("Hello", end="")` → Use `Console.Write("")` instead.  

### Input Function  

Not functional yet. Use the C# alternative:  
```csharp
Console.Write("Enter: ")
var input = Console.ReadLine()
```

### Misc
Check out my Bitcoin Miner game, I made it with this project in mind, it only works with CopperPython [Bitcoin Miner](https://github.com/s-rayyan/bitcoin-miner).
