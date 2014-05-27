#!/usr/bin/python

import sys

line_no = 0

while True:
	line = sys.stdin.readline()
	if not line:
		break
	line_no += 1
	if line_no == 1:
		continue
	uid, membership = line.split("\t")
	print "UPDATE user SET community = %s WHERE id = %s;" % (membership[:-1], uid)

