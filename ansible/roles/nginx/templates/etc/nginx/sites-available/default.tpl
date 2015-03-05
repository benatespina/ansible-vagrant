server {
  listen 80;

  server_name {{ servername }};
  index       app_dev.php index.html index.php;

  location @rewriteindex {
    root    {{ documentroot }};
    index   index.html index.htm index.php index.php?$query_string;
    rewrite ^(.*)$ /app_dev.php/$1 last;
  }
  location ~ ^/(app|app_dev|app_test)\.php(/|$) {
    root                    {{ documentroot }};
    include                 /etc/nginx/fastcgi_params;
    fastcgi_pass            {{ hhvmphpswitcher }};
    fastcgi_connect_timeout 3m;
    fastcgi_read_timeout    3m;
    fastcgi_send_timeout    3m;
    fastcgi_split_path_info ^(.+\.php)(/.+)$;
    include                 fastcgi_params;
  }
  location ~ \.php$ {
    root {{ documentroot }};
    proxy_intercept_errors   on;
    error_page               500 501 502 503 = @fpm-fallback;
    fastcgi_buffers          8 256k;
    fastcgi_buffer_size      128k;
    fastcgi_intercept_errors on;
    include                  /etc/nginx/fastcgi_params;
    fastcgi_pass             {{ hhvmphpswitcher }};
    fastcgi_param            SCRIPT_FILENAME $document_root$fastcgi_script_name;
    include                  fastcgi_params;
  }
  location / {
    root      {{ documentroot }};
    try_files $uri @rewriteindex;
  }
  location ~ ^/uploads/cache {
    root      {{ documentroot }};
    try_files $uri @rewriteindex;
    index     index.html index.htm index.php;
  }
  location @fpm-fallback {
    fastcgi_pass  php;
    fastcgi_index index.php;
    include       fastcgi_params;
  }
}
server {
  listen 443 ssl;

  server_name {{ servername }};
  ssl on;

  ssl_certificate     /etc/nginx/{{ host }}.crt;
  ssl_certificate_key /etc/nginx/{{ host }}.key;
}
