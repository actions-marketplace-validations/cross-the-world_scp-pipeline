FROM python:3.8.3-slim-buster

LABEL "maintainer"="Scott Ng <thuongnht@gmail.com>"
LABEL "repository"="https://github.com/cross-the-world/ssh-pipeline"
LABEL "version"="latest"

LABEL "com.github.actions.name"="scp-pipeline"
LABEL "com.github.actions.description"="Pipeline: scp"
LABEL "com.github.actions.icon"="copy"
LABEL "com.github.actions.color"="gray-dark"

RUN apt-get update -y && \
  apt-get install -y ca-certificates openssh-client openssl sshpass

COPY requirements.txt /requirements.txt
RUN pip3 install -r /requirements.txt

RUN mkdir -p /opt/tools
WORKDIR /opt/tools

COPY entrypoint.sh /opt/tools/entrypoint.sh
RUN chmod +x /opt/tools/entrypoint.sh

COPY app.py /opt/tools/app.py
RUN chmod +x /opt/tools/app.py

ENTRYPOINT ["./entrypoint.sh"]