 #!/bin/bash
 # A sample Bash script, by Ryan

echo Hello World!

#ps -aux | less
#ps -o etimes
#ps axjf

ps -eo pid,etime > time.txt

grep -oh "\w*:\w*" time.txt

#ps -A

#x=$(ps -e | wc -l)

#echo "${x}"

#ps -o etimes= -p "$$"
