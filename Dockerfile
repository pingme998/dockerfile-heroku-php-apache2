FROM futureys/amazon-linux2-ansible-python3:20200625064000
COPY ./ansible-playbook-heroku-php-apache /tmp/ansible-playbook
RUN /bin/bash -cl "cd /tmp/ansible-playbook \
 && ANSIBLE_FORCE_COLOR=1 PYTHONUNBUFFERED=1 ansible-playbook playbook.yml -vvv -c local -i inventories/container \
    --extra-vars '{ "simulate_amazon_linux_set_credentials_file": false }' \
 && rm -rf /tmp/*"
EXPOSE 80 443
ENTRYPOINT ["/usr/sbin/httpd"]
CMD ["-D", "FOREGROUND"]
