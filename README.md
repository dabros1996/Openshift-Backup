# Openshift-Backup
Openshift Backup
Here's an explanation of how the script works:

Set the backup_dir variable to the desired directory where the backups will be stored. Replace /path/to/backup/directory with the actual path.

Generate a timestamp using the date command to create a unique identifier for each backup.

Create a directory for the current backup using the timestamp.

Use the oc get all command to retrieve all resources from all namespaces and save the output in YAML format. The --export flag ensures that the exported content doesn't include cluster-specific metadata that can cause issues when re-applying the backup.

Use the oc get secrets command to retrieve all secrets from all namespaces and save the output in YAML format. The --export flag is used for the same reasons as in the previous step.

Save the output of both commands to files named all-resources.yaml and all-secrets.yaml within the current backup directory.

Display a success message indicating the location of the generated backup directory.

Make sure to replace /path/to/backup/directory with the actual path to the desired backup directory on your system.

Save the script to a file, for example, backup.sh, and make it executable:

chmod +x backup.sh

You can then run the script by executing ./backup.sh in the terminal. It will create a new backup directory, save the content (YAML definition) of all resources and secrets, and display a success message with the backup directory location.
