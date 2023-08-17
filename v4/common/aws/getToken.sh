#!/bin/bash
# Written with assistance from GPT4
# Based on https://gist.github.com/ogavrisevs/2debdcb96d3002a9cbf2

function show_help() {
  echo "Usage: $0 [MFA_TOKEN_CODE] [-h] [--help]"
  echo
  echo "This script updates the AWS session token for the specified profile."
  echo
  echo "Options:"
  echo "  MFA_TOKEN_CODE       The MFA token code to use for authentication."
  echo "                       If not provided, the script will prompt for it."
  echo "  -h, --help           Show this help message and exit."
}

function parse_arguments() {
  while [[ "$#" -gt 0 ]]; do
    case "$1" in
      -h|--help)
        show_help
        exit 0
        ;;
      *)
        if [[ -z "$mfa_token_code" ]]; then
          if [[ "$1" =~ ^[0-9]{6}$ ]]; then
            mfa_token_code="$1"
          else
            echo "Error: Invalid MFA token code. The code must be a 6-digit number."
            show_help
            exit 1
          fi
        else
          echo "Error: Unknown option or too many arguments: $1"
          show_help
          exit 1
        fi
        ;;
    esac
    shift
  done
}

function update_aws_mfa_profile() {
  # Read profile values from the ~/.aws/credentials file
  declare -A profile_values
  profile_names=()

  # Add a newline to the end of the input while reading the file
  while IFS="= " read -r key value || [[ -n "$key" ]]; do
    if [[ "$key" == \[*\] ]]; then
      profile_name="${key:1:-1}"
      profile_names+=("$profile_name")
    elif [[ -n $key ]]; then
      profile_values["${profile_name}_${key}"]="$value"
    fi
  done < <(cat ~/.aws/credentials; echo)

  # Prompt user to choose an AWS profile
  echo "Available AWS profiles:"
  for i in "${!profile_names[@]}"; do
    echo "$((${i} + 1)). ${profile_names[${i}]}"
  done

  read -p "Enter the number of the AWS profile you want to use: " profile_number
  chosen_profile="${profile_names[$((${profile_number} - 1))]}"
  echo "Chosen profile: $chosen_profile"

  # Retrieve the chosen profile values
  chosen_mfa_auth_profile="${profile_values["${chosen_profile}_mfa_auth_profile"]}"
  chosen_mfa_duration="${profile_values["${chosen_profile}_mfa_duration"]}"
  chosen_mfa_arn="${profile_values["${chosen_profile}_mfa_arn"]}"
  chosen_mfa_expiry="${profile_values["${chosen_profile}_mfa_expiry"]}"

  # Force mfa_duration to be interpreted as an integer using arithmetic expansion
  chosen_mfa_duration=$((chosen_mfa_duration))

  # Get the current time
  current_time=$(date +%s)

  # Check if the session token has expired
  if [[ -z "$chosen_mfa_expiry" ]] || [[ "$current_time" -gt "$chosen_mfa_expiry" ]]; then
    # Use the MFA token code provided as a command-line argument or prompt the user for it
    if [[ -n "$1" ]]; then
      mfa_token_code="$1"
    else
      read -p "Enter the MFA token code: " mfa_token_code
    fi

    # Call sts get-session-token with the selected profile values
    read new_aws_access_key_id new_aws_secret_access_key new_aws_session_token <<< \
    $(aws --profile "$chosen_mfa_auth_profile" sts get-session-token \
      --duration "$chosen_mfa_duration" \
      --serial-number "$chosen_mfa_arn" \
      --token-code "$mfa_token_code" \
      --output text | awk '{ print $2, $4, $5 }')

    # Update AWS CLI profile with the new session token values
    aws configure set aws_access_key_id "$new_aws_access_key_id" --profile "$chosen_profile"
    aws configure set aws_secret_access_key "$new_aws_secret_access_key" --profile "$chosen_profile"
    aws configure set aws_session_token "$new_aws_session_token" --profile "$chosen_profile"

    # Calculate and update mfa_expiry in the ~/.aws/credentials file
    new_mfa_expiry=$((current_time + chosen_mfa_duration))
    sed -i "/^\[${chosen_profile}\]$/,/^\[.*\]$/ s/mfa_expiry.*/mfa_expiry = ${new_mfa_expiry}/" ~/.aws/credentials

    # If the mfa_expiry key is not found in the chosen profile, append it
    if ! awk -v profile="^\[${chosen_profile}\]$" '
      /^\[.*\]$/ {
        in_profile = 0
      }
      $0 ~ profile {
        in_profile = 1
      }
      in_profile && /mfa_expiry/ {
        found = 1
      }
      END {
        exit !found
      }' ~/.aws/credentials; then
      sed -i "/^\[${chosen_profile}\]$/a mfa_expiry = ${new_mfa_expiry}" ~/.aws/credentials
    fi
  fi
}

# Execute the function if the script is being run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  parse_arguments "$@"
  update_aws_mfa_profile "$mfa_token_code"
fi