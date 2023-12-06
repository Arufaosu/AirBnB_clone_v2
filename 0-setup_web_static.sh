#!/usr/bin/env bash
# sets up your web servers

if ! command -v nginx &> /dev/null
then
    sudo apt-get update
    sudo apt-get -y install nginx
fi
sudo mkdir -p /data/web_static/releases/test /data/web_static/shared
echo "<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" | sudo tee /data/web_static/releases/test/index.html
sudo rm -f /data/web_static/current
sudo ln -s /data/web_static/releases/test/ /data/web_static/current
sudo chown -R ubuntu:ubuntu /data/
config_content="server {
    listen 80;
    server_name _;

    location /hbnb_static {
        alias /data/web_static/current;
        index index.html;
    }

    # Additional locations or configurations can be added here

    location /redirect_me {
        rewrite ^/redirect_me https://www.youtube.com permanent;
    }
}"
echo "$config_content" | sudo tee /etc/nginx/sites-available/default
sudo service nginx restart
exit 0
