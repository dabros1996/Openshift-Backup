#!/bin/bash

# Set the output directory for backups
backup_dir="/path/to/backup/directory"

# Create a timestamp for the backup
timestamp=$(date +%Y%m%d%H%M%S)

# Create a directory for the current backup
current_backup_dir="$backup_dir/backup_$timestamp"
mkdir -p "$current_backup_dir"

# Backup all resources using 'oc get all'
oc get all --all-namespaces -o yaml --export > "$current_backup_dir/all-resources.yaml"

# Backup secrets using 'oc get secrets'
oc get secrets --all-namespaces -o yaml --export > "$current_backup_dir/all-secrets.yaml"

echo "Backup completed successfully: $current_backup_dir"
