# OrangePiZeroMFRC522
RFID-MFRC522 module on Orangepi Zero running Armbian 5.27 Ubuntu Xenial.  
  
<img src="https://github.com/BiTinerary/OrangePiZeroMFRC522/blob/master/gitImgs/644.jpg" alt="modulePinout" width="417" height="320"><img src="https://github.com/BiTinerary/OrangePiZeroMFRC522/blob/master/gitImgs/833.jpg" alt="modulePinout" width="417" height="320">
  
When trying to get an RFID module to work with Orangepi Zero, there was alot of mixed information across forums and instructions. Some directions didn't even specify board model, only referencing **OrangePi** but supplying GPIO pins.  
  
Additionally, at the time of this repo's creation, all tutorials found use some hodgepodge mix match of other GPIO (RPI.GPIO/PyA20.GPIO) libraries that require editing MFRC522's source code, etc... Anyways, this is an attempt to collect all that information, simplify it, correct it and document it in one place.

## Build Materials
  * **Module**: MFRC522 aka RFID-RC522 module [|Buy|](https://www.aliexpress.com/item/RC522-Card-Read-Antenna-RFID-Reader-IC-Card-Proximity-Module/1859133832.html?spm=2114.13010608.0.0.sZMQVW) 
  * **Board**: Orangepi Zero v1.4 [|Buy|](https://www.aliexpress.com/item/New-Orange-Pi-Zero-H2-Quad-Core-Open-source-512MB-development-board-beyond-Raspberry-Pi/32761500374.html?spm=2114.13010608.0.0.sZMQVW)
  * **Kernel**: Armbian 5.27 3.4.113-sun8i Ubuntu Xenial 16.04 [|Download|](https://www.armbian.com/orange-pi-zero/)
  
## Requirements
  * **GPIO Library for Orangepi Zero**: https://github.com/rm-hull/OPi.GPIO
  * **SPI Library**: https://github.com/lthiery/SPI-Py.git

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

Third column is especially useful when trying to match up modules pin titles to schematic of a different board. It seems as though in almost all tutorials only pin numbers are referenced **or** pin functions. Both are useful depending on reference material and schematics. Not to mention if trying to determine proper pinout for a SPI/I2C module on a different board model that uses the same ARM processor, as listed in a random tutorial or search results.

## Installation

`git clone https://github.com/BiTinerary/OrangePiZeroMFRC522.git && bash ./OrangePiZeroMFRC522/getAllTheStuff.sh`

or the long manual way...

```sh
apt-get install python-dev -y
apt-get install python-pip -y
pip install --upgrade pip
pip install setuptools

git clone https://github.com/rm-hull/OPi.GPIO.git
cd OPi.GPIO
pip install .

cd ..
git clone https://github.com/lthiery/SPI-Py.git
cd SPI-Py
pip install .

cd ..
git clone https://github.com/BiTinerary/OrangePiZeroMFRC522.git
python ./OrangePiZeroMFRC522/MFRC522-python/Read.py
```

## Customizations

Swipe RFID chip >> Run command/script associated with that RFID tag.  
A hardware spin off of https://github.com/BiTinerary/PersonalAPI

[triggerRead.py](https://github.com/BiTinerary/OrangePiZeroMFRC522/blob/master/triggerRead.py) is the same source as original **Read.py** with a few modifications, mainly in the middle. I took out print statements throughout the source files (dump/read/MFRC/Write) just to clean up the scripts output. I added a **hashFile.txt** which stores values of a RFID chip and a local command as a dictionary. When RFID chip is scanned, execute it's value as a command. In the middle of **triggerRead.py** you can see the while loop to store the text file as key/value pairs. Then an `IF` statement that executes the value as a command, if the UID scanned matches the one stored in txt. If it doesn't match however, do nothing except print UID to output. This all happens [line 45-58](https://github.com/BiTinerary/OrangePiZeroMFRC522/blob/master/triggerRead.py#L45-L58)

## References
The main MFRC522 script in this repo is just a modified fork of https://github.com/mxgxw/MFRC522-python
