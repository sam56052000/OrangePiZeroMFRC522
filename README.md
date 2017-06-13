# OrangePiZeroMFRC522
RFID-MFRC522 module on Orangepi Zero running Armbian Ubuntu Xenial.  
  
When trying to get an RFID module to work with Orangepi Zero, there was alot of mixed information across forums and instructions. Some directions didn't even specify board model, only referencing **OrangePi** but supplying GPIO pins.  
  
Additionally, at the time of this repo's creation, all tutorials found use some hodgepodge mix match of other GPIO (RPI.GPIO/PyA20.GPIO) libraries that require editing MFRC522's source code, etc... Anyways, this is a simple attempt to collect all that information, simplify it, correct it and document it, in one place.

## Build Materials
  * **Module**: MFRC522 aka RFID-RC522 module [|Buy|](https://www.aliexpress.com/item/RC522-Card-Read-Antenna-RFID-Reader-IC-Card-Proximity-Module/1859133832.html?spm=2114.13010608.0.0.sZMQVW) 
  * **Board**: Orangepi Zero v1.4 [|Buy|](https://www.aliexpress.com/item/New-Orange-Pi-Zero-H2-Quad-Core-Open-source-512MB-development-board-beyond-Raspberry-Pi/32761500374.html?spm=2114.13010608.0.0.sZMQVW)
  * **Kernel**: Armbian 3.4.113-sun8i Ubuntu Xenial 16.04 [|Download|](https://www.armbian.com/orange-pi-zero/)
  
## Requirements
  * **GPIO Library for Orangepi Zero**: https://github.com/rm-hull/OPi.GPIO
  * **MFRC522 Library for interfacing with RFID**: https://github.com/mxgxw/MFRC522-python

Included in this repo is a modified clone of the above MFRC522 repo. The appropriate lines have been editted to work with Orangepi Zero. This includes replacing **line 1** `import RPI.GPIO as GPIO` with `import OPi.GPIO as GPIO` in all scripts and changing **Line 110** ( in **MFRC522.py**) from `spidev0.0` to `spidev1.0`. 

## Pinout
This is the proper way to connect MFRC522 module to Orangepi Zero board via SPI. First column lists pin names as seen on module, verbatim. Second is the Orangepi Zero's literal pin number. Third column is the OPiZero's pin function as seen from a data sheet.  

| MFRC522  | Board's Pin Number  |     Pin Function   |
|:--------:|:-------------------:|:------------------:|
| SDA      | Pin 3               | SPI1_CS/PA13       |
| SCK      | Pin 4               | SPI1CLK/PA14       |
| RST      | Pin 5               | UART2_RTS/PA02     |
| MISO     | Pin 6               | SPI1_MISO/PA16     |
| MOSI     | Pin 8               | SPI1_MOSI/PA15     |
| GND      | Pin 21              | GND                |
| 3.3v     | Pin 26              | 3.3v               |
-------------------------------------------------------

Third column is especially useful when trying to match up modules pin titles to schematic of a different board. It seems as though in almost all tutorials only pin numbers are referenced **or** pin functions. Both are useful depending on reference material, schematics and especially if trying to determine proper pinout for same SPI/I2C module on a different board model but with same CPU. So here it is, done right. IMO.

## Installation

```sh
apt-get install python-dev
apt-get install python-pip

git clone https://github.com/rm-hull/OPi.GPIO.git
cd OPi.GPIO
pip install .

cd ..
git clone https://github.com/BiTinerary/OrangePiZeroMFRC522.git
python ./OrangePiZeroMFRC522/MFRC522-python/Read.py
```

You may need to end up installing `setup-tools`. ie: `pip install setup-tools`
