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
sudo cp chargen kernal basic /usr/lib/vice/C64
cd vice-3.3/data/DRIVES
sudo cp d1541II d1571cr dos* /usr/lib/vice/DRIVES/
```

### C

Install [cc65](https://github.com/cc65/cc65) compiler. For Debian and Ubuntu based distributions, see [OBS: Debian .DEB and RPM](https://github.com/cc65/wiki/wiki/OBS%3A-Debian-.DEB-and-RPM).

```
cl65 -O -t c64 -o <binary>.prg <source_code>.c
```

### Assembly

First `sudo apt install default-jre` and then download [Kick Assembler](http://www.theweb.dk/KickAssembler/Main.html#frontpage). To assemble a program see here [here](http://www.theweb.dk/KickAssembler/webhelp/content/cpt_GettingStarted.html#d0e51). In a nutshell,


```
java -jar kickass.jar <binary>.asm
```


## Run

```
x64 <binary>.prg
```
