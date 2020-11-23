FROM alpine:3.7

RUN \
# apk add installs the following
apk add \
curl \
python \
py-pip \
py-boto \
py-dateutil \
py-httplib2 \
py-jinja2 \
py-paramiko \
py-setuptools \
py-yaml \
openssh-client \
bash \
tar && \
pip install –upgrade pip

# Makes a directory for ansible playbooks
RUN mkdir -p /ansible/playbooks
# Makes the playbooks directory the working directory
WORKDIR /ansible/playbooks

ENTRYPOINT ["./deploy.sh"]
 Sets entry point (same as running ansible-playbook)
ENTRYPOINT [“ansible-playbook”]