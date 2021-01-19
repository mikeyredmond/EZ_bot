#!/bin/sh
# Author: Mikey Redmond

# COVID-19 daily update for Ireland
url=https://www.gov.ie/en/news/7e0924-latest-updates-on-covid-19-coronavirus/#
date=$(date)

updated=$(wget -q -O - $url | sed '/reboot-markdown-bold/,$!d' |
sed -e 's/<[^>]*>//g' | sed 's/^[ \t]*//;s/[ \t]*$//')
echo Latest Update as of $date: "${updated%%:*}"
