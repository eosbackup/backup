#!/bin/bash

WORKDIR=/home/kzhukov/backups
ls $WORKDIR

cp /home/kzhukov/eos/db/eos.db $WORKDIR/eos_$(date +%d-%m-%Y).db


cd $WORKDIR
numOfFiles=$(ls *.db | wc -l)
echo $numOfFiles

while [[ numOfFiles -gt  5 ]]
do
	echo 'deleting old files'
	oldest=$(ls -1t  *.db | tail -1 )
	git rm $oldest
	echo $oldest was deleted
	numOfFiles=$(ls *.db | wc -l)	
done
	git add .
	git commit -m 'backup '+$(date +%d-%m-%Y)
	git push origin master
