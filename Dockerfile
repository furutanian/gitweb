FROM fedora

LABEL 'maintainer=Furutanian <furutanian@gmail.com>'

ARG TZ
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

RUN set -x \
	mv /etc/gitweb.conf /etc/gitweb.conf.org \
	&& cat /etc/gitweb.conf.org \
		| sed 's/^#\(our $projectroot\s*=\s*\).*/\1"\/var\/lib\/pv\/git";/' \
		> /etc/gitweb.conf \
	&& diff -C 2 /etc/gitweb.conf.org /etc/gitweb.conf \
	|| echo '/etc/gitweb.conf changed.'

RUN systemctl enable httpd

EXPOSE 80

