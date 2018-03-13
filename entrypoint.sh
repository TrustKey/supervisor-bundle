#!/bin/bash

if [ ! -d "/storage" ]; then
  echo "Fatal error: /storage directory is not mounted!";
  exit
fi

if [ ! -d "/storage/db" ]; then
  read -r -p "No /storage/db directory.. Initialize empty one? [y/N] " response
	case "$response" in
	    [yY][eE][sS]|[yY]) 
	        mkdir /storage/db
	        ;;
	    *)
	        echo "Goodbye!"
	        exit
	        ;;
	esac	
fi

service mongodb start

echo "Synchronizing local time..."
service ntp stop
ntpd -gq
service ntp start
npm start
bash