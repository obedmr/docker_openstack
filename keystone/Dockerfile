FROM ubuntu
MAINTAINER obed.n.munoz@gmail.com

RUN echo "deb http://ubuntu-cloud.archive.canonical.com/ubuntu" \
  "trusty-updates/kilo main" > /etc/apt/sources.list.d/cloudarchive-kilo.list
RUN apt-get update -y && apt-get dist-upgrade -y && apt-key update -y

# Utilities
RUN apt-get install -y mariadb-client crudini

# Install Keystone and dependencies
RUN echo "manual" > /etc/init/keystone.override
RUN apt-get install -y --force-yes keystone python-openstackclient apache2 \
    libapache2-mod-wsgi memcached python-memcache

# Keystone Configuration
RUN crudini --set /etc/keystone/keystone.conf DEFAULT admin_token ADMIN_TOKEN
RUN crudini --set /etc/keystone/keystone.conf database \
    connection mysql://keystone:secure@127.0.0.1/keystone
RUN crudini --set /etc/keystone/keystone.conf memcached \
    servers localhost:11211
RUN crudini --set /etc/keystone/keystone.conf token \
    provider keystone.token.providers.uuid.Provider
RUN crudini --set /etc/keystone/keystone.conf token \
    driver keystone.token.persistence.backends.memcache.Token
RUN crudini --set /etc/keystone/keystone.conf revoke \
    driver keystone.contrib.revoke.backends.sql.Revoke
RUN crudini --set /etc/keystone/keystone.conf DEFAULT \
    verbose True

EXPOSE 5000
EXPOSE 35357
EXPOSE 11211
CMD ["keystone-all"]