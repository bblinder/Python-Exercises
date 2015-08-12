#!/usr/bin/env python

import requests
import re

data = requests.get('http://icanhazip.com')
ISP = data.text

if '24.103.40.84' in ISP:
	print "Time Warner"

if '69.38.131.162' in ISP:
	print "TowerStream"

if ISP == "":
	print "DISCONNECTED"

