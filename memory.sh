#!/bin/bash

dmidecode -t memory | grep -E "Locator|Size|Form\ Factor|Type:|Speed" | grep -v "Correction"
