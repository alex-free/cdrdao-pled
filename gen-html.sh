#!/bin/bash
cd "$(dirname "$0")"
pandoc -s --template template.html --metadata title="cdrdao-af" readme.md -o readme.html
