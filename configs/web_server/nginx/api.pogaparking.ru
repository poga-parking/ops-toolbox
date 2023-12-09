upstream api {
	server 0.0.0.0:8080;
}
 
server {
	server_name api.pogaparking.ru;

	if ($scheme != "https") {
		return 301 https://$host$request_uri;
	}

	client_max_body_size 0;
	chunked_transfer_encoding on;

	proxy_buffering off;
	proxy_request_buffering off;

	location / {
		if ($request_method = 'OPTIONS') {
        		add_header 'Access-Control-Allow-Origin' '*';
        #
        # Om nom nom cookies
        #
        		add_header 'Access-Control-Allow-Credentials' 'true';
        		add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
        #
        # Custom headers and headers various browsers *should* be OK with but aren't
        #
        		add_header 'Access-Control-Allow-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type';
        #
        # Tell client that this pre-flight info is valid for 20 days
        #
        		add_header 'Access-Control-Max-Age' 1728000;
        		add_header 'Content-Type' 'text/plain charset=UTF-8';
        		add_header 'Content-Length' 0;
       			return 204;
     		}
     		if ($request_method = 'POST') {
        		add_header 'Access-Control-Allow-Origin' '*';
        		add_header 'Access-Control-Allow-Credentials' 'true';
        		add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
        		add_header 'Access-Control-Allow-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type';
     		}
     		if ($request_method = 'GET') {
        		add_header 'Access-Control-Allow-Origin' '*';
        		add_header 'Access-Control-Allow-Credentials' 'true';
        		add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
        		add_header 'Access-Control-Allow-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type';
     		}
		proxy_pass http://api/;
		proxy_set_header Host $http_host;
		proxy_set_header X-Real-IP $remote_addr;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_set_header X-Forwarded-Proto $scheme;

		proxy_http_version 1.1;
		proxy_set_header Connection "";
	}
	
	listen [::]:443; # managed by Certbot
    	ssl on;
	listen 443 ssl; # managed by Certbot	
    	ssl_certificate /etc/letsencrypt/live/api.pogaparking.ru/fullchain.pem; # managed by Certbot
    	ssl_certificate_key /etc/letsencrypt/live/api.pogaparking.ru/privkey.pem; # managed by Certbot
    	include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    	ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}

server {
    	if ($host = api.pogaparking.ru) {
        	return 301 https://$host$request_uri;
    	} # managed by Certbot


	listen 80 ;
	listen [::]:80 ;
    	server_name api.pogaparking.ru;
    	return 404; # managed by Certbot
}
