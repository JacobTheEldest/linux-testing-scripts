designwh=$(upower -i $(upower -e | grep BAT) | grep energy-full-design | awk {'print $2'})
fullwh=$(upower -i $(upower -e | grep BAT) | grep energy-full: | awk {'print $2'})
voltage=$(upower -i $(upower -e | grep BAT) | grep voltage | awk {'print $2'})
capacity=$(upower -i $(upower -e | grep BAT) | grep capacity: | awk {'print $2'})
empty=$(upower -i $(upower -e | grep BAT) | grep "time to empty:")

# convert Wh to mAh
designmAh=$(echo "$designwh * 1000 / $voltage" | bc)
fullmAh=$(echo "$fullwh * 1000 / $voltage" | bc)

#display results
echo
echo "Full Charge Capacity / Design Capacity: $capacity"
echo "Capacity (Whr): ${designwh%%.*}"
echo "Design Capacity (mAh): $designmAh"
echo "Full Charge Capacity (mAh): $fullmAh"
echo "Time to Empty: ${empty:25}"
echo
