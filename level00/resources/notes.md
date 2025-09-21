# Level00 Solution

## Steps:
1. Connected via SSH: `ssh level00@192.168.16.128 -p 4242`
2. Found a SUID binary owned by `flag00`:
   - Command: `find / -user flag00 2>/dev/null`
   - Output: `/usr/sbin/john`
3. Extracted readable strings from the binary:
   - Command: `strings /usr/sbin/john`
   - Found encoded password: `cdiiddwpgswtgt`
4. Decoded the password using ROT11:
   - Command: `echo "cdiiddwpgswtgt" | tr 'a-z' 'l-za-k'`
   - Decoded password: `nottoohardhere`
5. Switched to user `flag00`:
   - Command: `su flag00`
   - Password: `nottoohardhere`
6. Ran `getflag` to get the token for level01:
   - Token: `x24ti5gi3x0ol2eh4esiuxias`

## Notes:
- The alias in `.bashrc` was a red herring.
- The SUID binary `/usr/sbin/john` was not executable, but `strings` revealed the encoded password.
- Used ROT11 decoding (shift by 11) to decode the password.

## Tools used:
- `find`
- `strings`
- `tr` (for ROT11)
- `su`
- `getflag`