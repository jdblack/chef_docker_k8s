api_fqdn ENV['CINC_FQDN']

# Use the copy of the certs that we dropped from secrets
nginx['ssl_certificate']="/etc/cinc-project/certs/tls.crt"
nginx['ssl_certificate_key']="/etc/cinc-project/certs/tls.key"


# Externalize the database
postgresql['db_superuser'] = ENV['POSTGRES_USER']
postgresql['db_superuser_password'] = ENV['POSTGRES_PASSWORD']
postgresql['external'] = true
postgresql['vip'] = ENV['POSTGRES_FQDN']

# We use the db instead of the localfilesystem because our
# frontends are transient.  S3 is a better option if you have it!
bookshelf['storage_type'] = :sql

# We rely on the external ES host for search
elasticsearch['enable'] = false
opscode_erchef['search_queue_mode'] = 'batch'
opscode_erchef['search_provider'] = 'opensearch'
opensearch['external'] = true
opensearch['external_url'] = "http://#{ENV['SEARCH_FQDN']}:9200"
opscode_erchef['search_auth_username'] = ENV['SEARCH_USER']
opscode_erchef['search_auth_password'] = ENV['SEARCH_PASS']

