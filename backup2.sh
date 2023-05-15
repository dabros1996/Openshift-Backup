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

# Get the list of all resources from 'oc get all'
all_resources=$(oc get all --all-namespaces --no-headers | awk '{print $1" "$2}')

# Loop through each resource and save the describe content
while read -r resource; do
  namespace=$(echo "$resource" | awk '{print $1}')
  resource_name=$(echo "$resource" | awk '{print $2}')
  describe_content=$(oc describe "$resource_name" -n "$namespace")
  echo "$describe_content" > "$current_backup_dir/describe-$namespace-$resource_name.txt"
done <<< "$all_resources"

# Get the list of all secrets from 'oc get secrets'
all_secrets=$(oc get secrets --all-namespaces --no-headers | awk '{print $1" "$2}')

# Loop through each secret and save the describe content
while read -r secret; do
  namespace=$(echo "$secret" | awk '{print $1}')
  secret_name=$(echo "$secret" | awk '{print $2}')
  describe_content=$(oc describe secret "$secret_name" -n "$namespace")
  echo "$describe_content" > "$current_backup_dir/describe-$namespace-secret-$secret_name.txt"
done <<< "$all_secrets"

echo "Backup completed successfully: $current_backup_dir"
