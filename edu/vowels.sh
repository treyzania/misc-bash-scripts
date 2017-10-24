#!/bin/bash

novowels='[^aeiou]*'
regex=$novowels
for c in $(echo $1 | sed -e 's/\(.\)/\1\n/g'); do
	regex=$regex$c$novowels
done

echo $regex
grep -xE --color=no $regex /usr/share/dict/words
