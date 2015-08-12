#!/usr/bin/env python

i = 0
numbers = [] # Trying out lists instead of dicts

while i < 6:
	print "At the top i is %s" % i
	numbers.append(i)

	i = i + 1
	print "Numbers now: ", numbers
	print "At the bottom i is %s" % i

print "The numbers: "

for num in numbers:
	print num
