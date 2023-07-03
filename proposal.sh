#!/bin/bash

root_folder="$1"
template_file=""
readme_template_file=""
extension="json"
readme_extension="md"
timestamp=$(date +%Y_%m_%d)

# Check if the root folder is valid
if [ "$root_folder" != "evm" ] && [ "$root_folder" != "substrate" ]; then
  echo "Invalid root folder specified. Please use 'evm' or 'substrate' as the root folder representing supported chain architectures."
  exit 1
fi

# Determine the template file and readme file based on the root folder
if [ "$root_folder" == "evm" ]; then
  template_file="proposal_evm_template.json"
  readme_template_file="README_evm_template.md"
else
  template_file="proposal_substrate_template.json"
  readme_template_file="README_substrate_template.md"
fi

# Check if the template file exists
if [ ! -f "$template_file" ]; then
  echo "Template file not found: $template_file"
  exit 1
fi

# Check if the README template file exists
if [ ! -f "$readme_template_file" ]; then
  echo "README template file not found: $readme_template_file"
  exit 1
fi

# Check if there are any directory arguments provided
if [ $# -lt 2 ]; then
  echo "No directory arguments provided. Please specify at least one folder representing a chain name."
  exit 1
fi

# Determine the number of migrations based on the last argument
last_argument="${!#}"
if [[ "$last_argument" =~ ^[0-9]+$ ]]; then
  num_migrations="$last_argument"
else
  num_migrations=1
fi

# Iterate over each directory argument starting from the second one
for dir in "${@:2:$#-1}"; do
  # Check if the directory exists
  if [ ! -d "$root_folder/$dir" ]; then
    echo "Directory not found: $root_folder/$dir. Please ensure the folder represents a valid chain name."
    continue
  fi

  # Create README.md file if it does not exist
  readme_filename="$root_folder/$dir/README.${readme_extension}"
  if [ ! -f "$readme_filename" ]; then
    cp "$readme_template_file" "$readme_filename"
    echo "Copied README template file to: $readme_filename"
  fi

  # Generate the destination filenames
  for ((i = 1; i <= num_migrations; i++)); do
    filename="migration_${dir}_${timestamp}_$(printf "%02d" "$i").${extension}"
    destination="$root_folder/$dir/$filename"

    # Check if the destination file already exists
    if [ -f "$destination" ]; then
      echo "Duplicate found: $destination. Skipping."
      continue
    fi

    # Copy the template file to the destination
    cp "$template_file" "$destination"
    echo "Copied template file to: $destination"
  done
done
