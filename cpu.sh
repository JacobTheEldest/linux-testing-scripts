#!/bin/bash

#Trim leading and trailing whitespace
function trim () {
    trimmed=$@
    trimmed="${trimmed#"${trimmed%%[![:space:]]*}"}"
    trimmed="${trimmed%"${trimmed##*[![:space:]]}"}"
    echo "$trimmed"
}

#Initial info from lscpu
main=$(cat /proc/cpuinfo | grep -i -m 1 "Model\ name")
cores=$(cat /proc/cpuinfo | grep -i -m 1 "cpu cores" | awk {'print $NF'})

#Strip undesirable characters from cpu string
main=${main/model name/}
main=${main//:/}
main=${main//CPU/}
main=${main//(R)/}
main=${main//(TM)/\ }
main=${main//-/\ }
main=${main//@/}

# define variables and strip from main string
speed=$(echo $main | awk {'print $NF'})
main=${main/$speed/}
speed=$(echo ${speed:0:-3} ${speed: -3})

#manufacturer
manufacturer=$(echo $main | awk '{print $1}')
main=${main/$manufacturer/}

#model number
identifier=$(echo $main | awk '{print $(NF-1)}')
if [ ${#identifier} -eq 1 ]; then
    model_num="$(echo $main | awk '{print $NF}')$identifier"
    main=$(echo $main | awk '{$NF=$(NF-1)=""; print $0}')
else
    model_num=$(echo $main | awk {'print $NF'})
    main=${main/$model_num/}
fi

#model (trimming leading and trailing whitespace)
model=$(trim $main)


#output
echo
echo "Manufacturer:     $manufacturer"
echo "Model name:       $model"
echo "Model number:     $model_num"
echo "Speed:            $speed"
echo "Number of cores:  $cores"
echo
