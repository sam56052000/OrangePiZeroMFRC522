#!/bin/sh
apt-get install python-dev
apt-get install python-pip

git clone https://github.com/rm-hull/OPi.GPIO.git
cd OPi.GPIO
pip install .

cd ..
git clone https://github.com/BiTinerary/OrangePiZeroMFRC522.git
python ./OrangePiZeroMFRC522/MFRC522-python/Read.py
