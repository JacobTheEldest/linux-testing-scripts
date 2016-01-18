#!/bin/bash

#Initial info from lscpu
main=$(lscpu | grep "Model\ name:")
cores=$(lscpu | grep "socket:" | awk {'print $NF'})

#Strip undesirable characters from cpu string
main=${main/Model name: /}
main=${main/CPU/}
main=${main/(R)/}
main=${main/(TM)/\ }
main=${main/-/\ }
main=${main/@/}

#define variables and strip from main string
#speed
speed=$(echo $main | awk {'print $NF'})
main=${main/$speed/}
#manufacturer
manufacturer=$(echo $main | awk '{print $1}')
main=${main/$manufacturer/}
#model number
model_num=$(echo $main | awk {'print $NF'})
main=${main/$model_num/}
#model
model=$(echo $main | xargs)

#output
echo
echo "Manufacturer:     $manufacturer"
echo "Model name:       $model"
echo "Model number:     $model_num"
echo "Speed:            $speed"
echo "Number of cores:  $cores"
echo
