FROM fedora:latest

RUN dnf update -y && dnf install -y \
    nano \
    gcc-c++ \
    gcc \
    make \
    python3 \
    python3-pip \
    python3-virtualenv \
    python3-devel \
    git

RUN mkdir /instructlab && python3 -m venv /instructlab

RUN /instructlab/bin/pip install --upgrade pip && \
    /instructlab/bin/pip install instructlab --extra-index-url=https://download.pytorch.org/whl/cpu

ENV PATH="/instructlab/bin:$PATH"

RUN chown -R root:root /instructlab && chmod -R 755 /instructlab
RUN mkdir -p /ilab-config && chmod 555 /ilab-config
RUN mkdir -p /.local && chmod 777 /.local
COPY ilab/config.yaml /ilab/
COPY ilab/taxonomy/ /ilab/taxonomy/
RUN chmod -R 777 /

CMD ["tail", "-f", "/dev/null"]
