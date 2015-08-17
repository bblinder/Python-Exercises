#!/usr/bin/env python

# Working with lists. Taken from Learn Python The Hard Way

ten_things = "Apples Oranges Crows Telephone Light Sugar"

print "Wait, there are not 10 things in that list. Let's fix that."

stuff = ten_things.split(' ')
more_stuff = ["Day", "Night", "Song", "Frisbee", "Corn", "Banana", "Girl", "Boy"]

while len(stuff) != 10:
	next_one = more_stuff.pop()
	print "Adding: ", next_one
	stuff.append(next_one)
	print "There are %s items now." % len(stuff)

print "There we go: ", stuff

print "Lets do some things with stuff."

print stuff[1]
print stuff[-1] # Fancy?
print stuff.pop()
print ' '.join(stuff) # huh?
print "#".join(stuff[3:5])
