#!/bin/bash

set -e

apt update -y

# Install packages
apt install -y python3-pip python3-venv nginx

# Setup Python venv
python3 -m venv /home/ubuntu/venv
source /home/ubuntu/venv/bin/activate
pip install flask

# Create Flask app
cat <<EOF > /home/ubuntu/app.py
from flask import Flask
app = Flask(__name__)

@app.route("/")
def home():
    return " Flask behind Nginx (Production Style)"

app.run(host="0.0.0.0", port=5000)
EOF

# Run Flask app
cd /home/ubuntu
nohup /home/ubuntu/venv/bin/python app.py > app.log 2>&1 &

# Configure Nginx
cat <<EOF > /etc/nginx/sites-available/default
server {
    listen 80;

    location / {
        proxy_pass http://127.0.0.1:5000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
}
EOF

# Restart Nginx
systemctl restart nginx
systemctl enable nginx
