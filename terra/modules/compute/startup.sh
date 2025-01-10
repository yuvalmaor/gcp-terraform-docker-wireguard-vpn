#!/bin/bash
# Example script to install and start Apache
sudo echo "test1" >> /a.txt
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo echo "test3" >> /a.txt
sudo apt-get update
sudo echo "test4" >> /a.txt
#sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin 
sudo echo "end docker install" >> /a.txt
#sudo groupadd docker
#sudo usermod -aG docker $(getent passwd 1000 | cut -d: -f1)
USERNAME=$(getent passwd 1000 | cut -d: -f1)
if [ -n "$USERNAME" ]; then
    usermod -aG docker "$USERNAME"
fi
mkdir /app
cd /app

cat <<EOF > nginx.conf
events {}

http {
    server {
        listen 80;

        location / {
            default_type application/json;
            return 200 '{"success":true}';
        }
    }
}
EOF

echo "Custom nginx.conf created." >> /a.txt

# Step 2: Run the nginx container with the custom configuration
docker run --name custom-nginx -p 80:80 -v $(pwd)/nginx.conf:/etc/nginx/nginx.conf:ro -d nginx

if [ $? -eq 0 ]; then
    echo "Nginx container started successfully. Test with: curl http://localhost/" >> /a.txt
else
    echo "Failed to start the Nginx container." >> /a.txt
fi
#newgrp docker
#sudo apt-get update












# sudo apt-get install -y apache2
# sudo systemctl start apache2
# sudo systemctl enable apache2
#sudo echo "test" /a.txt