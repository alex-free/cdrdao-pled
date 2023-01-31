#!/bin/bash
cd "$(dirname "$0")"
pandoc -s --template template.html --metadata title="CDRDAO-PLED" readme.md -o readme.html
