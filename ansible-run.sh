#!/bin/bash

# Get values from Terraform outputs
# $HYFER_SSH_KEY is an enviornmental variable, do not add your key to the script
JUMPBOX_IP=$(terraform output -raw public_vm_public_ip)
WEBFRONT_1_IP=$(terraform output -raw webfront_vm_1_private_ip)
WEBFRONT_2_IP=$(terraform output -raw webfront_vm_2_private_ip)

if [[ -z "$HYFER_SSH_KEY" ]]; then
  echo "[FAILED] HYFER_SSH_KEY is not set. Please export it first (e.g., export HYFER_SSH_KEY=~/.ssh/your-key.pem)"
  exit 1
fi

# Create temporary inventory file
cat <<EOF > inventory.ini
[webfront]
$WEBFRONT_1_IP ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/.ssh/hyfer.pem
$WEBFRONT_2_IP ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/.ssh/hyfer.pem
EOF

# Create the Ansible playbook
cat <<EOF > nginx.yml
- name: Install Nginx on webfront servers
  hosts: webfront
  become: yes
  tasks:
    - name: Update apt
      apt:
        update_cache: yes

    - name: Upgrade all packages
      apt:
        upgrade: dist
        force_apt_get: yes

    - name: Install nginx
      apt:
        name: nginx
        state: present

    - name: Ensure nginx is started
      service:
        name: nginx
        state: started
        enabled: true
EOF

# Copy files to the jumpbox
scp -i $HYFER_SSH_KEY -o StrictHostKeyChecking=no inventory.ini nginx.yml ubuntu@$JUMPBOX_IP:/home/ubuntu/
scp -i $HYFER_SSH_KEY -o StrictHostKeyChecking=no "$HYFER_SSH_KEY" ubuntu@$JUMPBOX_IP:/home/ubuntu/.ssh/hyfer.pem

# Run Ansible remotely from the jumpbox
ssh -i $HYFER_SSH_KEY -o StrictHostKeyChecking=no ubuntu@$JUMPBOX_IP <<'EOF'
  sudo apt update && sudo apt install -y ansible
  ansible-playbook -i inventory.ini nginx.yml
EOF

# Clean up local temp files
rm inventory.ini nginx.yml

