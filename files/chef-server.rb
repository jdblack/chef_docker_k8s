api_fqdn ENV['CHEF_FQDN']

# Use the copy of the certs that we dropped from secrets
nginx['ssl_certificate']="/etc/opscode/certs/tls.crt"
nginx['ssl_certificate_key']="/etc/opscode/certs/tls.key"


# Externalize the database
postgresql['db_superuser'] = ENV['POSTGRES_USER']
postgresql['db_superuser_password'] = ENV['POSTGRES_PASSWORD']
postgresql['external'] = true
postgresql['vip'] = ENV['POSTGRES_FQDN']

# We use the db instead of the localfilesystem because our
# frontends are transient.  S3 is a better option if you have it!
bookshelf['storage_type'] = :sql

# We rely on the external ES host for search
opscode_solr4['external'] = true
opscode_solr4['external_url'] = "http://#{ENV['ES_FQDN']}:9200"

opscode_erchef['search_provider'] = 'elasticsearch'
opscode_erchef['search_queue_mode'] = 'batch' # es requires batch


opscode_expander['enable'] = false # expander doesnt work in batch mode

