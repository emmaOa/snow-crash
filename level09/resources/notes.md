# Level09 Solution

## Steps:
1. Connected via SSH: `ssh level09@192.168.16.128 -p 4242`
2. Found files in the home directory:
   - A setuid binary named `level09` (owned by `flag09`)
   - A read-only file named `token` (owned by `flag09`)

3. Analyzed the binary:
   - Ran `./level09 "abc"` which output `ace`
   - Discovered encryption algorithm: each character is shifted by its position index
   - Encryption formula: `encrypted_char = original_char + index`

4. Decrypted the token file:
   - The `token` file contained encrypted data: `f4kmm6p|=�p�n��DB�Du{��`
   - Created a Python script to reverse the encryption:
     - Decryption formula: `decrypted_char = encrypted_char - index`

5. Used the decrypted password to log in as `flag09`:
   - Command: `su flag09`
   - Password: `f3iji1ju5yuevaus41q1afiuq`

6. Ran `getflag` to get the token for the next level.

## Encryption/Decryption Logic:
- **Encryption**: `character + index`
  - Example: `"abc"` → `"ace"` (a+0=a, b+1=c, c+2=e)
- **Decryption**: `encrypted_character - index`

## Python Decryption Script:
```python
data = open('token', 'rb').read()
result = ''
for i in range(len(data)):
    decrypted_val = ord(data[i]) - i
    decrypted_val = decrypted_val % 256
    result += chr(decrypted_val)
print(result)