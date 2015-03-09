#!/bin/sh
apt-get update -y && apt-get upgrade -y && \
apt-get install software-properties-common -y && \
sudo add-apt-repository ppa:ondrej/php5 -y && \
apt-get update && \
apt-get install git tig mc htop git-flow vim links unzip bash-completion curl ant -y && \
echo mysql-server mysql-server/root_password password 'secret' | debconf-set-selections && \
echo mysql-server mysql-server/root_password_again password 'secret' | debconf-set-selections && \
apt-get -y install mysql-server && \
mysqladmin -u root -p'secret' password '' && \
apt-get install php5-fpm php5-cli php5-curl php5-intl php5-mysqlnd php5-sqlite php5-imagick php5-memcached php-pear php5-xdebug php5-dev -y && \
apt-get install nginx -y && \
apt-get install memcached -y && \
apt-get install ruby ruby-dev -y && \
gem install compass --no-ri --no-rdoc && \
wget https://raw.githubusercontent.com/nixilla/php-dev-stack/master/config/nginx/default.conf -O /etc/nginx/sites-available/default > /dev/null 2>&1 && \
sed -i "s/user[ \t]*www-data;/user vagrant;/" /etc/nginx/nginx.conf && \
sed -i "s^user = www-data^user = vagrant^" /etc/php5/fpm/pool.d/www.conf && \
sed -i "s^group = www-data^group = vagrant^" /etc/php5/fpm/pool.d/www.conf && \
sed -i "s^listen = /var/run/php5-fpm.sock^listen = 127.0.0.1:9000^" /etc/php5/fpm/pool.d/www.conf && \
sed -i "s^;date.timezone =^date.timezone = Europe/London^" /etc/php5/fpm/php.ini && \
sed -i "s^;date.timezone =^date.timezone = Europe/London^" /etc/php5/cli/php.ini && \
service nginx restart && service php5-fpm restart && \
chown vagrant:vagrant /home/vagrant/.ssh/id_rsa && \
chmod 600 /home/vagrant/.ssh/id_rsa && \
chown vagrant:vagrant /home/vagrant/.gitconfig && \
sed -i "s^#force_color_prompt=yes^force_color_prompt=yes^" /home/vagrant/.bashrc
ln -s /usr/local/bin/compass /usr/bin/compass

wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -O /etc/bash_completion.d/git-completion.bash
wget https://raw.githubusercontent.com/KnpLabs/symfony2-autocomplete/master/symfony2-autocomplete.bash -O /etc/bash_completion.d/symfony2-completion.bash
