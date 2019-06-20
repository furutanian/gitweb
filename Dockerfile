FROM fedora

LABEL 'maintainer=Furutanian <furutanian@gmail.com>'

ARG http_proxy
ARG https_proxy

RUN set -x \
	&& dnf install -y \
		httpd \
		git \
		gitweb \
		procps-ng \
		net-tools \
	&& rm -rf /var/cache/dnf/* \
	&& dnf clean all

## git clone gitwev しておくこと
COPY gitweb/dav.conf /etc/httpd/conf.d

RUN systemctl enable httpd

EXPOSE 80

