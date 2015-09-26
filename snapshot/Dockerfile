FROM buildpack-deps:jessie
MAINTAINER papaeye@gmail.com

RUN curl -sSL http://emacs.secretsauce.net/key.gpg | apt-key add -

RUN echo 'deb [arch=amd64] http://emacs.secretsauce.net unstable main' \
	> /etc/apt/sources.list.d/emacs-snapshot.list

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		emacs-snapshot-nox=2:20150920+emacs-24.5-rc3-fixed-5952-g00a65e3-1 \
	&& rm -rf /var/lib/apt/lists/*

ENV CASK_VERSION 8337237449446e186ccd5ade0b0dc8c6ea7bd728

RUN mkdir /opt/cask \
	&& curl -sSL https://github.com/cask/cask/archive/$CASK_VERSION.tar.gz \
		| tar -xzC /opt/cask --strip-components=1

ENV PATH /opt/cask/bin:$PATH

# bootstrap
RUN cask version

CMD ["emacs"]
