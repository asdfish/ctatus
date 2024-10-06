# ctatus
slstatus alternative

## Building
~~~sh
git clone https://github.com/asdfish/ctatus
cd ctatus
sudo make install
~~~

## Configuration
Configuration of ctatus is done in [config.h](./config.h).
Example configs can be found in [./examples](./examples) and [./config.h](./config.h)

## Usage
Usage depends on the window manager/bar that you're using, and may require some hacking

### Examples:

#### Waybar
~~~json
{
    "modules-right": [
        "custom/ctatus"
    ],
    "custom/ctatus": {
        "exec": "ctatus"
    }
}
~~~

### Dwm
~~~sh
patch -i patches/dwm.patch
~~~
