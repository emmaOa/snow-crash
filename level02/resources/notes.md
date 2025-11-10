# Level02 Solution

## Steps:
1. Connected via SSH: `ssh level02@192.168.16.128 -p 4242`
2. Found a network capture file in the home directory:
   - Command: `ls -la`
   - Output: `----r--r-- 1 flag02 level02 8302 Aug 30 2015 level02.pcap`
3. Analyzed the PCAP file to extract the password:
   - Used `tcpdump` to filter packets destined for port 12121 (telnet) with length 1 (keystrokes):
     ```bash
         tcpdump -r level02.pcap -A -l | grep -A 50 "Password"
     ```
   - Extracted password: `ft_waNDReL0L`
4. Switched to user `flag02`:
   - Command: `su flag02`
   - Password: `ft_waNDReL0L` → Success!
5. Ran `getflag` to get the token for level03:
   - Token: `kooda2puivaav1idi4f57q8iq`

## Notes:
- The `.pcap` file contains a telnet session where keystrokes are sent in plaintext.
- Each keystroke is captured in a separate packet (length 1).
- The command extracts the hex data from the packets and converts it to ASCII.

## Tools used:
- `tcpdump`
- `grep` (with Perl regex)
- `xxd` (hex to ASCII conversion)
- `su`
- `getflag`