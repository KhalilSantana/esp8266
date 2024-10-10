# Usage

```bash
export MY_ESP8266_SERIAL="/dev/ttyUSB0"  # Mount whatever your ESP8266 serial device is in your system into the container
export MY_CODE="$PWD"                    # Mount the current working directory inside /mnt/code/vol 
# Run container, delete after closing 
sudo -E docker run --rm -it              \
    -v "$MY_CODE":/mnt/code/vol          \
    -v $MY_ESP8266_SERIAL:/dev/ttyUSB0   \
    ghcr.io/khalilsantana/esp8266
```

## Self test (inside the container)
```bash
cd hello_world/
make -j$(nproc) flash
```

## Common Errors

### Errors about /dev/ttyUSB0
> **NOTE:** This will give you the error below if you don't have a `/dev/ttyUSB0` in your system. See the MY_ESP8266_SERIAL environment variable.

<details>
<summary>Example Error Output</summary>

```
Flashing binaries to serial port /dev/ttyUSB0 (app at offset 0x10000)...
esptool.py v2.4.0
Traceback (most recent call last):
  File "/usr/local/lib/python3.12/dist-packages/serial/serialposix.py", line 322, in open
    self.fd = os.open(self.portstr, os.O_RDWR | os.O_NOCTTY | os.O_NONBLOCK)
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
IsADirectoryError: [Errno 21] Is a directory: '/dev/ttyUSB0'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/opt/ESP8266_RTOS_SDK/components/esptool_py/esptool/esptool.py", line 3034, in <module>
    _main()
  File "/opt/ESP8266_RTOS_SDK/components/esptool_py/esptool/esptool.py", line 3027, in _main
    main()
  File "/opt/ESP8266_RTOS_SDK/components/esptool_py/esptool/esptool.py", line 2735, in main
    esp = chip_class(args.port, initial_baud, args.trace)
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/opt/ESP8266_RTOS_SDK/components/esptool_py/esptool/esptool.py", line 212, in __init__
    self._port = serial.serial_for_url(port)
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/dist-packages/serial/__init__.py", line 90, in serial_for_url
    instance.open()
  File "/usr/local/lib/python3.12/dist-packages/serial/serialposix.py", line 325, in open
    raise SerialException(msg.errno, "could not open port {}: {}".format(self._port, msg))
serial.serialutil.SerialException: [Errno 21] could not open port /dev/ttyUSB0: [Errno 21] Is a directory: '/dev/ttyUSB0'
make: *** [/opt/ESP8266_RTOS_SDK/components/esptool_py/Makefile.projbuild:76: flash] Error 1
```
</details>

### Running apt install <package> fails

Run `apt update`, then try again.