FROM pytorch/pytorch:2.5.1-cuda12.4-cudnn9-runtime

# Set environment variables
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul
ENV PYTHONUNBUFFERED=1
ENV PYTHONIOENCODING=UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
# Change ubuntu repository to Kakao mirror
RUN sed -i 's|http://[a-z]\+.ubuntu.com|https://mirror.kakao.com|g' /etc/apt/sources.list
# Configure python repository with Kakao mirror
RUN printf "%s\n"\
    "[global]"\
    "index-url=https://mirror.kakao.com/pypi/simple/"\
    "extra-index-url=https://pypi.org/simple/"\
    "trusted-host=mirror.kakao.com"\
    > /etc/pip.conf && pip install --no-cache-dir -U pip && pip install --no-cache-dir idna jupyter
# Install essential packages
RUN apt-get update -qq && apt-get install -qqy\
        sudo\
        tzdata\
        curl\
        git\
    && apt clean && rm -rf /var/lib/apt/lists/*

RUN apt update && apt install -qqy \
    ffmpeg libsm6 libxext6 xvfb

ENV PYTHONPATH=/workspace
WORKDIR /workspace
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY setup.py /workspace/
RUN pip install -e .