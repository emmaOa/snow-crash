#!/bin/bash

tcpdump -r level02.pcap -nn -X 'dst port 12121 and length 1' | grep -oP '0x0030:.* \K[0-9a-f]{2}$' | xxd -r -p