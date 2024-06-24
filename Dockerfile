FROM ubuntu:latest

RUN apt update
RUN apt install sniproxy dnsmasq iptables dnsdist -y #haproxy -y
ADD dnsmasq.conf /etc/dnsmasq.tpl
#ADD haproxy.conf /etc/haproxy/haproxy.tpl
ADD sniproxy.conf /etc/sniproxy.conf
ADD dnsdist.conf /etc/dnsdist/dnsdist.tpl
RUN ln -sf /dev/stdout /var/log/sniproxy/sniproxy.log

EXPOSE 53/udp
EXPOSE 80
EXPOSE 443
EXPOSE 853

# Replace your server's public IP instead of SERVER_IP below.
# You can also specify who has access to connect to this DNS server

ENV IP 1.2.3.4
ENV SERVER_DOMAIN doh.example.com
ENV ALLOWED_IP 0.0.0.0/0

CMD echo "Configure iptables..." && \
    iptables -A INPUT --source ${ALLOWED_IP} --jump ACCEPT && \
    iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED --jump ACCEPT && \
    iptables -P INPUT DROP && \
    iptables -S && \
    echo "Configure dnsmasq..." && \
    cat /etc/dnsmasq.tpl /adblock/result.tpl > /etc/dnsmasq-candidate.tpl && \
    sed "s/{IP}/${IP}/" /etc/dnsmasq-candidate.tpl > /etc/dnsmasq.conf && \
    echo "Configure dnsdist..." && \
    sed "s/{SERVER_DOMAIN}/${SERVER_DOMAIN}/g" /etc/dnsdist/dnsdist.tpl > /etc/dnsdist/dnsdist.conf && \
    chown -R _dnsdist:_dnsdist /etc/letsencrypt && \
    #echo "Configure haproxy..." && \
    #sed -e "s/{IP}/${IP}/" -e "s/{SERVER_DOMAIN}/${SERVER_DOMAIN}/" /etc/haproxy/haproxy.tpl > /etc/haproxy/haproxy.conf && \
    echo "Run sniproxy, dnsdist and dnsmasq..." && \
    service dnsdist start && \
    dnsmasq -khR & sniproxy -c /etc/sniproxy.conf -f
