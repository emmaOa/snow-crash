#!/bin/bash

echo "Enter text to decode:"
read text
echo "$text" | tr 'a-z' 'l-za-k'