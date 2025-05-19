#!/bin/bash

# Check if the log file directory is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <logfile_directory>"
  exit 1
fi

# Get the log file directory from the first argument
LOGFILE_DIR="$1"

# Ensure the log file directory exists
if [ ! -d "$LOGFILE_DIR" ]; then
  echo "Error: Directory '$LOGFILE_DIR' does not exist."
  exit 1
fi

# Generate a timestamp for the log file
DATE_STR=$(date +"%Y_%m_%d_%I_%M_%p")

# Full log file path
LOGFILE_PATH="${LOGFILE_DIR}/new_fq_backup_${DATE_STR}.log"

# Run the sync and log the output in a screen session
sudo screen -S backup_new_fq -L -Logfile "$LOGFILE_PATH" bash -c "
  rsync -avh --progress --remove-source-files --update --no-links /media/storageD/data/new_fastqs/ /mnt/Engram_Locker/fastq/ &&
  find /media/storageD/data/new_fastqs/ -type d -empty -print -delete
"
