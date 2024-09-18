#!/bin/bash

file="file.txt"
> "$file"

for (( i=128; i<192; i++ )); do
    for (( j=0; j<256; j++ )); do
        for (( k=0; k<256; k++ )); do
            for (( l=0; l<256; l++ )); do
                ip="$i.$j.$k.$l"
                echo "testing $ip"
                timeout 15 adb connect "$ip" 2>/dev/null
                output=$(adb devices)
                adb disconnect >/dev/null
                last_line=$(echo "$output" | awk -F '\n' '{print $NF}')
                if [[ "$last_line" == *.* ]]; then
                    echo "$last_line" >> "$file"
                    echo "$last_line succeeded"
                fi
            done
        done
    done
done
