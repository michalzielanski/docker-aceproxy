FROM ubuntu:14.04

ENV DEBIAN_FRONTEND=noninteractive
RUN \
    apt-get update && \
    apt-get install -y --no-install-recommends curl ca-certificates && \
    echo 'deb http://repo.acestream.org/ubuntu/ trusty main' > /etc/apt/sources.list.d/acestream.list && \
    curl -L http://repo.acestream.org/keys/acestream.public.key | apt-key add - && \
    apt-get update && \
    \
    apt-get install -y --no-install-recommends acestream-engine vlc-nox python-pip python-gevent python-psutil && \
    rm -rf /var/lib/apt/lists/* && \
    \
    mkdir -p /app && cd /app && \
    curl -L -o v0.9.1.tar.gz https://github.com/ValdikSS/aceproxy/archive/refs/tags/v0.9.1.tar.gz && \
    tar zxf v0.9.1.tar.gz && rm v0.9.1.tar.gz && mv aceproxy-*/* . && rmdir aceproxy-* && \
    \
    apt-mark auto curl ca-certificates && \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false

RUN sed -i 's/geteuid/getppid/' /usr/bin/vlc

RUN \
    sed -i 's/vlcuse = False/vlcuse = True/' /app/aceconfig.py; \
    sed -i 's/videoobey = True/videoobey = False/' /app/aceconfig.py; \
    sed -i 's/videopausedelay = .*/videopausedelay = 0/' /app/aceconfig.py; \
    sed -i 's/videodelay = .*/videodelay = 0/' /app/aceconfig.py; \
    sed -i 's/videodestroydelay = .*/videodestroydelay = 30/' /app/aceconfig.py; \
    \
    sed -i 's/acespawn = False/acespawn = True/' /app/aceconfig.py; \
    sed -i 's/vlcspawn = False/vlcspawn = True/' /app/aceconfig.py; \
    sed -i 's/acecmd = .*/acecmd = "acestreamengine --client-console --log-stdout --live-cache-type memory"/' /app/aceconfig.py

EXPOSE 8000

WORKDIR /app
ENTRYPOINT ["python2", "acehttp.py"]
