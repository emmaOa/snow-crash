# Level01 Solution

## Steps:
1. Connected via SSH: `ssh level01@192.168.16.128 -p 4242`
2. Found the hash for `flag01` in `/etc/passwd`:
   - Command: `cat /etc/passwd | grep flag01`
   - Output: `flag01:42hDRfypTqqnw:3001:3001::/home/flag/flag01:/bin/bash`
   - The second field (`42hDRfypTqqnw`) is the encrypted password.
3. Cracked the hash using John the Ripper on a local machine:
   - Created a file `hash.txt` with the line: `flag01:42hDRfypTqqnw:3001:3001::/home/flag/flag01:/bin/bash`
   - Ran: `john hash.txt`
   - Ran: `john --show hash.txt`
   - Cracked password: `abcdefg`
4. Switched to user `flag01`:
   - Command: `su flag01`
   - Password: `abcdefg` → Success!
5. Ran `getflag` to get the token for level02:
   - Token: `f2av5il02puano7naaf6adaaf`

## Notes:
- The hash `42hDRfypTqqnw` is a traditional Unix `crypt(3)` hash (salted DES).
- John the Ripper was used to crack the password.
- The password for `flag01` is `abcdefg`.

## Tools used:
- `grep`
- John the Ripper (on local machine)
- `su`
- `getflag`