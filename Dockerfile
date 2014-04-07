# fuel-nailgun
#
# Version     0.1

FROM centos
MAINTAINER Matthew Mosesohn mmosesohn@mirantis.com

WORKDIR /root

RUN yum install -y yum-utils
RUN yum-config-manager --add-repo=http://srv11-msk.msk.mirantis.net/fwm/4.1/centos/os/x86_64/ --save
RUN yum-config-manager --add-repo=http://10.20.0.2:8080/centos/fuelweb/x86_64/ --save
RUN sed -i 's/gpgcheck=1/gpgcheck=0/' /etc/yum.repos.d/* /etc/yum.conf
RUN rm -f /etc/yum.repos.d/CentOS*
RUN yum --quiet install -y puppet python-pip rubygems-openstack
RUN yum --quiet install -y nginx python-fuelclient supervisor postgresql-libs rsyslog fence-agents

ADD etc /etc

RUN cp /etc/puppet/modules/nailgun/examples/ostf-only.pp /root/site.pp
#ADD site.pp /root/site.pp
RUN puppet apply -d -v /root/site.pp

RUN mkdir -p /usr/local/bin
ADD start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh
EXPOSE 8777
CMD /usr/local/bin/start.sh
