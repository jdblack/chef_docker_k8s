api_fqdn ENV['CHEF_FQDN']
nginx['ssl_certificate']="/etc/opscode/certs/tls.crt"
nginx['ssl_certificate_key']="/etc/opscode/certs/tls.key"
postgresql['db_superuser'] = ENV['POSTGRES_USER']
postgresql['db_superuser_password'] = ENV['POSTGRES_PASSWORD']
postgresql['external'] = true
postgresql['vip'] = ENV['POSTGRES_FQDN']


