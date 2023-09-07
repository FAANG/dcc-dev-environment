FROM python:3.9.7

WORKDIR /

RUN apt update && apt install openssh-server sudo -y
RUN groupadd sshgroup && useradd -ms /bin/bash -g sshgroup sshuser
RUN mkdir -p /home/sshuser/.ssh
COPY idkey.pub /home/sshuser/.ssh/authorized_keys
RUN chown sshuser:sshgroup /home/sshuser/.ssh/authorized_keys && chmod 600 /home/sshuser/.ssh/authorized_keys
RUN service ssh start
EXPOSE 22

ADD requirements.txt ./
RUN pip install -r requirements.txt
RUN pip install --upgrade awscli
ENV PYTHONUNBUFFERED=1

COPY ./credentials /credentials

# CMD ["python", "-c", "while True: pass"]
CMD ["/usr/sbin/sshd", "-D", "-e"]
