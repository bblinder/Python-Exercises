#!/usr/bin/env python

try:
	import paramiko
except ImportError:
	print "Cannot import 'Paramiko' - please check that it's installed"
	print "Exiting..."
	sys.exit()

import getpass
import os
import sys

server = raw_input("Server: ")
username = raw_input("Username: ")
password = getpass.getpass()

ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

try:
	ssh.connect(hostname=server, username=username, password=password)
	stdin, stdout, stderr = ssh.exec_command("cat /proc/interrupts")
	for line in stdout.readlines():
		print line.strip()
	print "Done. Closing."
	ssh.close()
except paramiko.AuthenticationException:
	print "Authentication Failed"
	sys.exit()

