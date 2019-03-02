FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8


RUN useradd -m ankisyncd && \
  apt update && apt upgrade -y && \
  apt install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-setuptools \
    python3-dev \
    python3-pyaudio \
    build-essential \
    git && \
  git clone --depth=1 https://github.com/tsudoko/anki-sync-server /anki-sync-server && \
  cd /anki-sync-server && \
  git submodule update --init && \
  cd anki-bundled && \
  pip3 install -r requirements.txt && \
  cd .. && \
  pip3 install webob configparser && \
  apt autoremove -y git build-essential && \
  apt-get clean

WORKDIR /anki-sync-server

USER ankisyncd

EXPOSE 27701

ENTRYPOINT ["python3"]

CMD ["-m", "ankisyncd"]
