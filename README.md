# Usage

```bash
# Run container, delete after closing 
# Mount the current working directory inside /mnt/code/vol 
# Mount whatever your ESP8266 serial device is in your system into the container
sudo docker run --rm -it              \
    -v "$PWD":/mnt/code/vol           \
    -v /dev/ttyUSB0:/dev/ttyUSB0      \
    ghcr.io/khalilsantana/esp8266
```

## Self test (inside the container)
```bash
cd hello_world/
make -j$(nproc) flash
```