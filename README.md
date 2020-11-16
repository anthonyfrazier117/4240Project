# 4240Project
Project to detect and kill processes running for a set amount of time
In order to use the scrip place the process file and config file in the same directory and execute the process file.
The config file controls settings for filter processes based on time, logging to a file or command line, and filtering for cpu usage.
The first number in the config controls how long the processes must run for in seconds before being detected, it can be changed to
any integer number.
The second word controls wether or not to log the output to a log file or output to the terminal, yes for logging and no for terminal output
the next word is the name of the output file you want to create. This output file will contain all of process output unfiltered
The final word is a number indicating the cpu usage you want to filter for, this will tell the program to record any process that
has a cpu usage of above the number, any number followed by a decimal can be entered here