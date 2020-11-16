 #!/usr/bin/env bash
 # A simple Bash script


testing=$(head -n 1 config.txt)
echo "$testing"

a=( $testing )
echo ${a[0]}
echo ${a[1]}
echo ${a[2]}
echo ${a[3]}

typeset -i timeLimit=${a[0]}
fileLogging=${a[1]}
outputfile=${a[2]}
cpuLimit=${a[3]}

ps -eo pid,etime,%mem > $outputfile


input=$outputfile
while IFS= read -r line
do
   y=$(echo $line | awk '{print $2}')
   x=(${y//:/})
   cpuUsage=$(echo $line | awk '{print $3}')
   if [ "$x" -gt "$timeLimit" ] || [ "${cpuUsage%.*}" -gt "${cpuLimit%.*}" ];
   then
	if [ "$fileLogging" == "yes" ]
	then
	    echo $line >> log_file.txt
	else
	    echo $line
	fi
   fi
   #echo $y

done < "$input"

echo $testing
echo $timeLimit
echo $fileLogging
