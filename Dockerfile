FROM ubuntu:24.04
RUN apt update &&\
    apt upgrade -y &&\
    apt install -y python3         \
                   python3-pip     \
                   python3-venv    \
                   make            \
                   cmake           \
                   curl            \
                   git             \
                   libncurses5-dev \
                   flex \
                   bison \
                   gperf \
                   python-is-python3 && rm -rf /var/lib/apt/lists/* && apt clean
RUN mkdir /opt/esp8266-toolchain && \
    curl -Lo esp8266-toolchain.tgz https://dl.espressif.com/dl/xtensa-lx106-elf-gcc8_4_0-esp-2020r3-linux-amd64.tar.gz && \
    tar xzvf esp8266-toolchain.tgz -C /opt/esp8266-toolchain/ && \
    rm esp8266-toolchain.tgz
RUN git clone --recursive --depth 1 https://github.com/espressif/ESP8266_RTOS_SDK.git /opt/ESP8266_RTOS_SDK
ENV IDF_PATH="/opt/ESP8266_RTOS_SDK"
ENV PATH="/opt/esp8266-toolchain/xtensa-lx106-elf/bin:$PATH"
RUN mkdir /mnt/code
WORKDIR /mnt/code
RUN cp -r $IDF_PATH/examples/get-started/hello_world/ .
RUN python3 -m pip install -r $IDF_PATH/requirements.txt --break-system-packages
RUN apt update && apt install -y minicom && rm -rf /var/lib/apt/lists/* && apt clean

