FROM loopbackkr/pytorch:2.0.0-cuda11.7-cudnn8-devel

ARG USER=hyunseoki
ARG XDG_RUNTIME_DIR=1000194
RUN groupadd --gid $XDG_RUNTIME_DIR $USER &&\
    useradd --uid $XDG_RUNTIME_DIR --gid $XDG_RUNTIME_DIR -m $USER &&\
    apt update -qq && apt install -qqy sudo &&\
    echo $USER ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USER &&\
    chmod 0440 /etc/sudoers.d/$USER

RUN apt update && apt install -qqy \
    ffmpeg libsm6 libxext6 xvfb

WORKDIR /workspace
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install -e .

RUN chown $USER:$USER /workspace
USER $USER
ENV PYTHONPATH=/workspace