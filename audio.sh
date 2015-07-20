#!/bin/bash

amixer sset 'Master' 100%
amixer sset 'Front' 100%
find /usr -name Josh* -exec rhythmbox '{}' \;
