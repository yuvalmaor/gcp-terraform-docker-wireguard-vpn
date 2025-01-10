#!/bin/bash

# Navigate to the Terraform directory
TERRAFORM_DIR="./terra/"
cd "$TERRAFORM_DIR" || { echo "Terraform directory not found"; exit 1; }

# Apply the Terraform configuration
echo "Running Terraform apply..."
terraform apply -auto-approve

# Check if the apply was successful
if [ $? -ne 0 ]; then
  echo "Terraform apply failed. Exiting."
  exit 1
fi

# Get the IP address from Terraform output
VM_IP=$(terraform output -raw vm_ip)

# Check if the IP was retrieved
if [ -z "$VM_IP" ]; then
  echo "Failed to retrieve VM IP from Terraform output. Exiting."
  exit 1
fi

echo "VM IP retrieved: $VM_IP"

# URL to check
URL="http://$VM_IP/"

# Target success message
TARGET_RESPONSE='{"success":true}'

# Loop until the target response is received
while true; do
  # Get the response from the URL with a 5-second timeout
  RESPONSE=$(curl -s --max-time 3 "$URL")

  # Check if the response matches the target
  if [[ "$RESPONSE" == "$TARGET_RESPONSE" ]]; then
    echo "Success! Target response received: $RESPONSE"
    break
  else
    echo "Response does not match or request timed out. Retrying in 5 seconds..."
  fi

  # Wait for 10 seconds before retrying
  sleep 5
done

ssh-keygen -f '/home/mejerowicz-y/.ssh/known_hosts' -R "$VM_IP"
ssh yuvalnix305@"$VM_IP"  -o StrictHostKeyChecking=no 'echo "SSH connection successful."'
pwd
ls 
ls ..
ssh yuvalnix305@"$VM_IP"  -o StrictHostKeyChecking=no 'mkdir ~/app'
scp ../cloudserver/docker-compose.yml yuvalnix305@"$VM_IP":app/docker-compose.yml

ssh yuvalnix305@"$VM_IP"  -o StrictHostKeyChecking=no << EOF

ls
ls app
cd app
ls
docker compose up -d
EOF