# Level12 Solution

## Vulnerability Analysis
The Perl script `level12.pl` is vulnerable to command injection. The critical flaw is in this line:
```perl
@output = `egrep "^$xx" /tmp/xd 2>&1`;