#!/bin/bash

echo 'How many seconds would you like to limit processes to? (Ex. 3000)'
read -r limit_time
if [ -z "$limit_time" ] || ! [[ $limit_time =~ ^[0-9]+$ ]]; then
    echo 'You must enter a valid time limit.'
    exit 0
fi

echo ''
echo 'Do you want to output to log file or terminal? yes/no'
echo '(yes to log in file, no to output to terminal)'
read -r output_format
if [ -z "$output_format" ] || ! ([ "$output_format" = "yes" ] || [ "$output_format" = "no" ]); then
    echo "You must enter 'yes' or 'no'"
    exit 0
fi

echo ''
echo 'What would you like the output file name to be?'
echo '(enter something arbitrary if logging to terminal)'
read -r file_name
if [ -z "$file_name" ] || ! ([[ $file_name =~ ^[a-zA-Z0-9_-]+\.[A-Za-z]{3}$ ]] || [[ $file_name =~ ^[a-zA-Z0-9_-]+$ ]]); then
    echo 'You must enter a valid file name.'
    exit 0
fi

echo ''
echo 'Over what percentage would you like to filter processes by cpu usage? (Ex. 10.0)'
read -r cpu_percentage
if [ -z "$cpu_percentage" ] || ! [[ $cpu_percentage =~ ^[0-9]+([,.][0-9]{1})?$ ]]; then
    echo 'You must enter a percentage.'
    exit 0
fi

echo ''
echo 'Would you like to create a cron entry? yes/no'
echo '(If you are outputting to terminal, enter no)'
read -r cron_entry
if [ -z "$cron_entry" ] || ! ([ "$output_format" = "yes" ] || [ "$output_format" = "no" ]); then
    echo "You must enter 'yes' or 'no'"
    exit 0
fi

rm -f config.txt
echo "$limit_time $output_format $file_name $cpu_percentage" >>config.txt

if [ "$cron_entry" = "yes" ]; then
    echo ''
    echo 'Enter the FULL file path to the location of process.sh script. (Ex. /home/user/dir/process.sh)'
    read -r file_path

    if [ -f "$file_path" ]; then
        crontab -l >current_crontab
        echo "00 17 * * * $file_path" >>current_crontab
        crontab current_crontab
        rm current_crontab
    else
        echo "$file_path is not a valid path to process.sh"
    fi
fi
