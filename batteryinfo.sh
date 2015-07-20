designwh=$(upower -i $(upower -e | grep BAT) | grep energy-full-design | awk {'print $2'})
fullwh=$(upower -i $(upower -e | grep BAT) | grep energy-full: | awk {'print $2'})
voltage=$(upower -i $(upower -e | grep BAT) | grep voltage | awk {'print $2'})

echo
echo "Capacity (Whr):"
echo "${designwh%%.*}"
echo
echo "Design Capacity (mAh):"
echo "$designwh * 1000 / $voltage" | bc
echo
echo "Full Charge Capacity (mAh):"
echo "$fullwh * 1000 / $voltage" | bc
echo 
echo "Full Charge Capacity / Design Capacity:"
upower -i $(upower -e | grep BAT) | grep capacity: | awk {'print $2'}
echo
