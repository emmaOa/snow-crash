# Level13 Solution

## Vulnerability:
The binary checks if the user's UID equals 4242 using `getuid()` system call.

## Exploitation:
Used GDB to modify the return value of `getuid()` from 2013 to 4242.

## Steps:
1. `gdb -q level13`
2. `break main`
3. `run` 
4. `disassemble` - to find the instruction after getuid call
5. `break *0x0804859a` - break after getuid returns
6. `continue` - reach the breakpoint
7. `set $eax=4242` - modify UID to bypass check
8. `continue` - get the token

## Technical Details:
- `getuid()` returns the UID in register EAX
- The comparison `cmp $0x1092,%eax` checks if UID == 4242
- By modifying EAX before the comparison, we bypass the check

## Token:
2A31L79asukciNyi8uppkEuSx