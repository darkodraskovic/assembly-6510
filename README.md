# c64 Programming

## Installation

### VICE emulator

Install VICE:

```
sudo apt-get install vice
```

Install the kernal and other files needed to run C64 emulator:

```
wget http://www.zimmers.net/anonftp/pub/cbm/crossplatform/emulators/VICE/vice-3.3.tar.gz
tar -zxvf vice-3.3.tar.gz
cd vice-3.3/data/C64

# on RPi only
sudo mkdir ~/.local/share/vice/C64
sudo mkdir ~/.local/share/vice/DRIVES
sudo mkdir ~/.local/share/vice/C128

# on RPi replace /usr/lib/vice with ~/.local/share/vice
sudo cp chargen kernal basic /usr/lib/vice/C64
cd vice-3.3/data/DRIVES
sudo cp d1541II d1571cr dos* /usr/lib/vice/DRIVES/

cd vice-3.3/data/C128
sudo cp chargen* kernal* basic* /usr/lib/vice/C128

```

#### Build vice on RPi with SDL GUI


```
sudo apt-get install libsdl2-dev libsdl2-2.0-0 libsdl2-image-dev libsdl2-image-2.0-0 libsdl2-ttf-2.0-0 libsdl2-ttf-dev
sudo apt-get install flex byacc dos2unix xa65 texinfo texlive-binaries libglew2.1 libglew-dev
```

Go to https://vice-emu.sourceforge.io/ and download `vice-3.6.1.tar.gz`. Unpack it and `cd` to `vice-3.6.1` and

```
./configure --prefix=/home/pi/viceinstall --enable-sdlui2 --without-oss --enable-ethernet --disable-catweasel --without-pulse
make -j $(nproc)
```

### C

Install [cc65](https://github.com/cc65/cc65) compiler. For Debian and Ubuntu based distributions, see [OBS: Debian .DEB and RPM](https://github.com/cc65/wiki/wiki/OBS%3A-Debian-.DEB-and-RPM).

```
cl65 -O -t c64 -o <binary>.prg <source_code>.c
```

### Assembly

First `sudo apt install default-jre` and then download [Kick Assembler](http://www.theweb.dk/KickAssembler/Main.html). To assemble a program see here [here](http://www.theweb.dk/KickAssembler/webhelp/content/cpt_GettingStarted.html). In a nutshell,


```
java -jar kickass.jar <binary>.asm
```

### Debugger
https://github.com/sunsided/c64-debugger

```
sudo apt-get install gcc g++ libgtk-3-dev libasound2-dev mesa-common-dev libxcb-util* 
cd MTEngine/
make
```

### Monitor
"The VICE emulator has a complete built-in [monitor](https://vice-emu.sourceforge.io/vice_12.html)". You can start monitor with File > Activate monitor or with `Alt + H`.

## Run

```
x64 <binary>.prg
```
