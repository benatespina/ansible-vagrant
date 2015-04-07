# Default Apache virtualhost template

<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot {{ documentroot }}
    ErrorLog /var/log/apache2/error.log
    CustomLog /var/log/apache2/access.log combined
    {% set servernames = servername.split() %}
    {% for servername in servernames %}
        {% if loop.first %}
            ServerName {{ servername }}
        {% else %}
            ServerAlias {{ servername }}
        {% endif %}
    {% endfor %}
    <Directory {{ documentroot }}>
        AllowOverride All
        Order allow,deny
        Allow from all
    </Directory>
</VirtualHost>
