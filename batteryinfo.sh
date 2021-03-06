#!/bin/bash

batpath=$(upower -e | grep BAT)

# Count the number of batteries
numbats="0"
for i in $batpath; do
	numbats=$((numbats + 1))
done

# print number of batteries detected
echo
if [ $numbats -eq 0 ]; then
    echo "No battery detected."
elif [ $numbats -eq 1 ]; then
    echo "Detected 1 battery"
else
    echo "Detected $numbats batteries."
fi

iteration="0"
while [ $iteration -lt $numbats ]; do
	iteration=$((iteration + 1))

	batpath=$(upower -e | grep -m $iteration BAT | tail -1)

	# store fields in variables
    designwh=$(upower -i $batpath | grep energy-full-design | awk {'print $2'})
    fullwh=$(upower -i $batpath | grep energy-full: | awk {'print $2'})
    voltage=$(upower -i $batpath | grep voltage | awk {'print $2'})
    capacity=$(upower -i $batpath | grep capacity: | awk {'print $2'})
    percentage=$(upower -i $batpath | grep percentage: | awk {'print $2'})
    empty=$(upower -i $batpath | grep "time to empty:")

    # convert Wh to mAh
    designmAh=$(echo "$designwh * 1000 / $voltage" | bc)
    fullmAh=$(echo "$fullwh * 1000 / $voltage" | bc)

    # strip % from variable
    capacity=${capacity::-1}

    # correct for inaccuracies in Capacity (Whr)
    whr=$(echo "$designwh - 1" | bc)


    # use capacity to calculate fullmAh if it is equal to design mAh
    if [ $fullmAh -eq $designmAh ]; then
        fullmAh=$(echo "$designmAh * $capacity / 100" | bc)
    fi
    if [ $(echo " $fullwh == $whr" | bc) -eq 1 ]; then
        fullwh=$(echo "$designwh * $capacity / 100" | bc)
    fi
    if [ $(echo " $fullwh > $whr" | bc) -eq 1 ]; then
        fullwh=$whr
    fi

    #display results
    echo
	echo "Battery #$iteration"
    echo "Full Charge Capacity / Design Capacity: $capacity%"
    echo "Design Capacity (Whr): ${whr%%.*}"
    echo "Full Charge Capacity (Whr): ${fullwh%%.*}"
    echo "Currrent Percentage: $percentage"
    echo "Time to Empty: ${empty:25}"
    echo
done
