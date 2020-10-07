#!/bin/bash
# A small Bash script to set up User LED3 to be turned on or off from
#  Linux console. Written by Derek Molloy (derekmolloy.ie) for the
#  book Exploring BeagleBone.

LED3_PATH=/sys/class/leds/beaglebone:green:usr3

blink=$1
n=$2

# Example bash function
function removeTrigger
{
  echo "none" >> "$LED3_PATH/trigger"
}
echo "	"
echo "Starting the LED Bash Script"

if [ $# -eq 0 ]; then
  echo "There are no arguments."
  echo "Use command as ./led-hw4.sh blink [number of blinks]"
  echo "	"
  exit 2
fi

echo "The LED command that was passed is: $1"

if [ "$1" == "blink" ]; then
  counter=0;
  echo "Blinking the LED $2 times"
  while [ $counter -lt "$2" ]
   do
    removeTrigger
    echo "1" >> "$LED3_PATH/brightness"
    sleep 1
    echo "0" >> "$LED3_PATH/brightness"
    sleep 1
    ((counter++))
  done
elif [ "$1" == "off" ]; then
  echo "Turning off the LED"
  removeTrigger
  echo "0" >> "$LED3_PATH/brightness"
elif [ "$1" == "flash" ]; then
  echo "Flashing the LED"
  removeTrigger
  echo "timer" >> "$LED3_PATH/trigger"
  sleep 1
elif [ "$1" != "blink" ]; then
  echo "Please enter command as ./led-hw4.sh blink [number of blinks]"
fi
echo "End of the LED Bash Script"
echo "	"

