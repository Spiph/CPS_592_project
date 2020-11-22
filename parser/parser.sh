#! /bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: ./parser.sh <log file to process> <output file>"
    echo "Suggested: ./parser.sh tank1.log tank1.csv"
    exit 1
fi

echo "Processing $1"
cat $1 | grep "LOG IDENTIFIER" | cut -c 18-| sed -E 's/LOG IDENTIFIER/\n&/p' | sed -E 's/.*Time/Time/' | uniq > tempOut
python log_reading.py tempOut > $2
echo "Result file: $2"
rm tempOut