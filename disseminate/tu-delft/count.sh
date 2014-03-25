#!/bin/sh

printf "Bachelor's project: "
sed '1,/Final/ d' essay.mdwn |wc -w|tr -d '\n'
printf ' words (They request 1000 to 1500 words.)\n'

printf "Full essay:         "
cat essay.mdwn|wc -w|tr -d '\n'
printf ' words (They request a maximum of 250 words.)\n'
