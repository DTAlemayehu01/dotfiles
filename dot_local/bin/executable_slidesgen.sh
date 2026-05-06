#!/bin/sh

# Bash Script to generate Template 

# Homework File Instantiation
echo "Filename (dont forget .tex extension)":
read filename
touch $filename

# Document Data
echo Author:
read author
echo Title:
read title
echo Institute:
read institute
date_value=$(date "+%d %b, %Y")

preamble=$(cat ~/.local/bin/script-resources/slide-preamble.txt)
cubeamer=$(ls ~/.local/bin/script-resources/cubeamer.cls)

curr_dir=$PWD

cp $cubeamer $PWD
cp -r ~/.local/bin/script-resources/img $PWD

# Latex file printing
printf '%s\n' "$preamble" >> $filename

printf "\n" >> $filename

printf "\\\title{${title}}\n" >> $filename
printf "\\\author{${author}}\n" >> $filename
printf "\\\date{${date_value}}\n" >> $filename
printf "\\\institute[University of Colorado Boulder]{${institute}}\n" >> $filename

printf "\n" >> $filename

printf "\\\begin{document}\n" >> $filename
printf "\\\maketitle\n" >> $filename
printf "\\\end{document}\n" >> $filename
