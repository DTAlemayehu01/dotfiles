#!/bin/sh

# 
# Bash Script to generate Template 
# 

# Array Constants
sectionheader=("section*" "subsection*", "subsubsection*")
declare -a numberalphabet=("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40") # Bash lmao
declare -a alphabet=("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l") # This isn't literally the full alphabet lmao
declare -a iphabet=("i", "ii", "iii", "iv", "v", "vi", "vii", "viii", "ix", "x") # Roman numberals lmao

declare -a groups=("numberalphabet", "alphabet", "iphabet")

# Homework File Instantiation
echo "Filename (dont forget .tex extension)":
read filename
touch $filename

# Document Data
echo Real Name:
read real_name
echo Homework \#:
read hw_no
echo Reciation \#:
read rec_no
echo Section \#:
read sec_no
echo \# Of Problems:
read prob_no
#echo "Input Problem structure, Rules are below:"
#echo "1. Each input will be a tuple of (section-level number) and comma delimited"
#echo "2. The section-level starts a 0 for section, 1 for subsection, etc."
#echo "3. The number denotes at which point the problem occurs in the level, (i.e. problem1a is inputted as 1, p1b is inputted as 2"
#echo "4. The input is comma delimited, NO SPACES outside of separating values in an input"
#echo "5. Good input looks like, 1 4,2 4,3 5, ..."
#read input

preamble=$(cat /home/danny/.local/bin/script-resources/preamble.txt)

# Latex file printing
printf '%s\n' "$preamble" >> $filename

printf "\\\begin{document}\n" >> $filename

printf "\\\begin{FlushRight}\n" >> $filename
printf "$real_name\\\newline\n" >> $filename
printf "HW \#${hw_no}\\\newline\n" >> $filename
if ! [ -z "${rec_no}" ]; then printf "Recitation ${rec_no}\\\newline\n" >> $filename; fi
if ! [ -z "${sec_no}" ]; then printf "Section ${sec_no}\\\newline\n" >> $filename; fi
printf "\\\end{FlushRight}\n" >> $filename

printf "\\\begin{FlushLeft}\n" >> $filename
for i in $(seq 1 $prob_no);
do
	printf "\\section*{Problem %s}\n" "$i" >> $filename
	printf "\\\newpage\n" >> $filename
done
printf "\\\end{FlushLeft}\n" >> $filename

printf "\\\end{document}\n" >> $filename
