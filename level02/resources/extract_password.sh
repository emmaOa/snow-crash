#!/bin/bash

tcpdump -r level02.pcap -A -l | grep -A 50 "Password"