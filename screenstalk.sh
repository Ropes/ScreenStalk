#!/bin/sh

hash xwd 2>&-
if [ $? -eq 0 ]
then
  cmd=`xwd -root | convert xwd:- ` 
else
  echo "xwd not installed on system"
  exit 0
fi

echo -n "Enter number of minutes between screen captures:"
read nap

ne=$(( nap * 5 ))

echo -n "Enter filename:"
read name

save_dir="$HOME/screenstalk"

if [ ! -d $save_dir ]
then
  mkdir $save_dir 
fi

i=0
while true
do
  time=`date +%H:%M:%S`

  filename="$name:$i::$time.png" 
  echo "$time $i"
  screen="$save_dir/$filename" 

  exe=$cmd $screen
  #echo "$exe"
  #$exe
  
  xwd -root | convert xwd:- $screen 

  sleep $ne 
  i=$(( $i + 1 ))
done
