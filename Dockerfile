FROM alpine:latest

RUN addgroup ankisyncd && \
  adduser -h /home/ankisyncd -g '' -G ankisyncd -D ankisyncd && \
  apk upgrade -U && \
  apk add --no-cache \
    python3 \
    py3-setuptools \
    python3-dev \
    git && \
  git clone --depth=1 https://github.com/tsudoko/anki-sync-server /home/ankisyncd/ankisyncd.git && \
  cd /home/ankisyncd/ankisyncd.git && \
  git submodule update --init && \
  cd anki-bundled && \
  sed -i 's/^pyaudio$//g' requirements.txt && \
  pip3 install --no-cache-dir -r requirements.txt && \
  cd .. && \
  pip3 install --no-cache-dir webob configparser && \
  apk del git py3-setuptools python3-dev && \
  rm -rf /var/cache/* && \
  sed -i 's/\.\//\/home\/ankisyncd\/data\//g' ankisyncd.conf && \
  mkdir /home/ankisyncd/data && \
  chown -R ankisyncd:ankisyncd /home/ankisyncd

WORKDIR /home/ankisyncd/ankisyncd.git

USER ankisyncd

EXPOSE 27701

ENTRYPOINT ["python3"]

CMD ["-m", "ankisyncd"]

