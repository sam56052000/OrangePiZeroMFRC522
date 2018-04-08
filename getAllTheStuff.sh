#!/bin/sh
apt-get update
apt-get install -y python-dev python-pip
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
python ./OrangePiZeroMFRC522/MFRC522-python/Read.py
