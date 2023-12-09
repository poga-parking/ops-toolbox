upstream backend {
	server 0.0.0.0:5000;	
}

server {
	server_name pogaparking.ru;

	if ($scheme != "https") {
		return 301 https://$host$request_uri;
	}

	client_max_body_size 0;
	chunked_transfer_encoding on;

	proxy_buffering off;
	proxy_request_buffering off;

	location / {
		return 301 $scheme://parking-web-ui.pages.dev$request_uri;
		proxy_pass http://backend/;
		proxy_set_header Host $http_host;
		proxy_set_header X-Real-IP $remote_addr;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_set_header X-Forwarded-Proto $scheme;

		proxy_http_version 1.1;
		proxy_set_header Connection "";
	}
	
	listen [::]:443 ssl ipv6only=on; # managed by Certbot
    	listen 443 ssl; # managed by Certbot
    	ssl_certificate /etc/letsencrypt/live/pogaparking.ru/fullchain.pem; # managed by Certbot
    	ssl_certificate_key /etc/letsencrypt/live/pogaparking.ru/privkey.pem; # managed by Certbot
    	include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    	ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}

server {
    	if ($host = pogaparking.ru) {
        	return 301 https://$host$request_uri;
    	} # managed by Certbot


	listen 80 ;
	listen [::]:80 ;
    	server_name pogaparking.ru;
    	return 404; # managed by Certbot
}
