#!/bin/sh
# Author: Mikey Redmond

arg1=$1
# The first argument you type into the command-line

url=https://bigcharts.marketwatch.com/quickchart/quickchart.asp?symb=$arg1
# This is the url to access whatever company's stock price page hence symb=$arg1

# echo $url
# This is a test to see if it is making the url I commented it after I made sure it was correct

wget -q -O - $url > test.htm
# This line sents the pages contents into a file called test.htm

cat test.htm | head -200 |
# This line displays the contents of the file then requests to see the first 200 lines of
# test.htm and then pipes the output

sed '/Last:/,$!d' > test2.htm
# This line displays the string where 'Last:' is a substring and displays every line that
# comes after it and sends the output to a new file

sed -e 's/<[^>]*>//g' test2.htm > final.htm
# This line removes all of the html tags and sends the output to a new file

cat final.htm | tr -d '\040\011\012\015' |
# This line displays the contents of the file and pipes the contents to a program that
# removes spaces, tabs, newline characters and carriage returns, this output gets piped
# to another program

cut -d ":" -f2 |
# This line gets rid of everything before and including ":" this output is piped again

sed -e 's/Change//g'
# This line gets rid of "Change" which is a substring of the final answer,
# it then returns the price
