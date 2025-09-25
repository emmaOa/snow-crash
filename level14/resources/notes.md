# Level14 Solution

## Vulnerability Analysis
The challenge was hosted on a custom Apache server (port `4747`) configured with a CGI script (`level04.pl`). The key vulnerability was **command injection** via unsanitized user input in the CGI parameters.

## Steps to Solve
1.  **Discovery**: Found an Apache VirtualHost listening on port `4747` by checking `/etc/apache2/sites-enabled/level05.conf`.
2.  **Configuration Analysis**: The configuration revealed a CGI script (`level04.pl`) in `/var/www/level04/` that runs with the privileges of user `flag04`.
3.  **Exploitation**: The script used user input from the `x` parameter unsafely. The payload `` `getflag` `` was injected through this parameter, causing the server to execute the command with elevated privileges.
4.  **Execution**: The exploit was triggered using `curl` to send an HTTP GET request with the malicious payload.

## Exploit Command
```bash
curl "http://localhost:4747/level04.pl?x=\`getflag\`"