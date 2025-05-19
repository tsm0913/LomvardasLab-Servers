#!/bin/bash

# Check if the log file path is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <logfile_path>"
  exit 1
fi

# Get the log file path from the first argument
LOGFILE_PATH="$1"

# Generate a timestamp for the log file
DATE_STR=$(date +"%Y_%m_%d_%I_%M_%p")

# Full log file path with timestamp
FULL_LOGFILE="${LOGFILE_PATH}/aphrodite_backup_${DATE_STR}.log"

# Run the backup commands and log output
sudo screen -S backup_aphrodite -L -Logfile "$FULL_LOGFILE" bash -c '
sudo rsync -avh --info=progress2 --update --no-links --exclude="*.Rdata" --exclude="*.RData" --exclude="*.fastq" --exclude="*.sam" --max-size=20g --delete --ignore-errors /home/ /mnt/icarus2/data/AphroditeBackup/home/;
sudo rsync -avh --info=progress2 --update --no-links --exclude="*.Rdata" --exclude="*.RData" --exclude="*.fastq" --exclude="*.sam" --max-size=20g --delete --ignore-errors /media/storageA/ /mnt/icarus2/data2/AphroditeBackup/storageA/;
sudo rsync -avh --info=progress2 --update --no-links --exclude="*.Rdata" --exclude="*.RData" --exclude="*.fastq" --exclude="*.sam" --max-size=20g --delete --ignore-errors /media/storageB/ /mnt/icarus2/data/AphroditeBackup/storageB/;
sudo rsync -avh --info=progress2 --update --no-links --exclude="*.Rdata" --exclude="*.RData" --exclude="*.fastq" --exclude="*.sam" --max-size=20g --delete --ignore-errors /media/storageC/ /mnt/icarus2/data/AphroditeBackup/storageC/;
sudo rsync -avh --info=progress2 --update --no-links --exclude="*.Rdata" --exclude="*.RData" --exclude="*.fastq" --exclude="*.sam" --max-size=20g --delete --ignore-errors /media/storageD/ /mnt/icarus2/data/AphroditeBackup/storageD/;
sudo rsync -avh --info=progress2 --update --no-links --exclude="*.Rdata" --exclude="*.RData" --exclude="*.fastq" --exclude="*.sam" --max-size=20g --delete --ignore-errors /media/storageE/ /mnt/icarus2/data/AphroditeBackup/storageE/;
'
