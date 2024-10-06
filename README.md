# ctatus
slstatus alternative

## Building
~~~bash
git clone https://github.com/asdfish/ctatus
cd ctatus
sudo make install
~~~

## Usage
Usage depends on the window manager/bar that you're using, and may require some hacking

### Waybar
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
