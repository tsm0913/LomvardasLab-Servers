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

# Run the sync and log the output
rsync -avh --progress --remove-source-files --update --no-links /media/storageD/data/new_fastqs/ /mnt/Engram_Locker/fastq/ >> "$LOGFILE_PATH" 2>&1

# Remove empty directories and log the deletions
find /media/storageD/data/new_fastqs/ -type d -empty -print -delete >> "$LOGFILE_PATH" 2>&1
