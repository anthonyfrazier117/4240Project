 #!/bin/bash
 # A sample Bash script, by Ryan

echo Hello World!

#ps -aux | less
#ps -o etimes
#ps axjf

#grep -oh "\w*:\w*" time.txt |

ps -eo pid,etime > time.txt

input="time.txt"
while IFS= read -r line
do
   #echo "$line"
   y=$(echo $line | awk '{print $2}')
    #echo $y
    x=(${y//:/})
    #echo $x
   #echo $1
   if [ $x -gt 2000 ]
   then
	echo $y
   fi
   #echo $y


done < "$input"

#ps -A

#x=$(ps -e | wc -l)

#echo "${x}"

#ps -o etimes= -p "$$"
