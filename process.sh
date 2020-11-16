 #!/usr/bin/env bash
 # A simple Bash script


testing=$(head -n 1 config.txt)
echo "$testing"

a=( $testing )

typeset -i timeLimit=${a[0]}
fileLogging=${a[1]}
outputfile=${a[2]}
cpuLimit=${a[3]}

ps -eo pid,etime,%mem,user,cmd,lstart > $outputfile


maxCpuProcess="0."
CpuMaxLine=""

now=$(date)
echo "Ran at: $now" >> log_file.txt

input=$outputfile
while IFS= read -r line
do
   y=$(echo $line | awk '{print $2}')
   x=(${y//:/})
   cpuUsage=$(echo $line | awk '{print $3}')
   if [ "$x" -gt "$timeLimit" ] || [ "${cpuUsage%.*}" -gt "${cpuLimit%.*}" ];
   then
	if [ "${cpuUsage%.*}" -gt "${maxCpuProcess%.*}" ];
	then
	    maxCpuProcess=$cpuUsage
	    cpuMaxLine=$line
	fi
	if [ "$fileLogging" == "yes" ]
	then
	    echo $line >> log_file.txt
	else
	    echo $line
	fi
   fi
   #echo $y
done < "$input"

echo "You're biggest cpu usage was:"
echo $cpuMaxLine
