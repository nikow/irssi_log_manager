#!/bin/bash
# Delete logs from previous year. Run every first day of the year afer logs rotate.

set -e
set -x

year=`date +%4Y -d "1 year ago"`

# go to irclogs, decompress all log from the last year, put them into tar, remove old logs
cd ~/irclogs && xz -dv */\#*$year-*.log*xz && tar cvf $year.tar */\#*$year-*.log* && rm -v */\#*$year-*.log* || exit 1

# compress them
xz -9ev $year.tar

# delete all not needed directories
find ~/irclogs -depth -type d -empty -exec rmdir -v {} \;
