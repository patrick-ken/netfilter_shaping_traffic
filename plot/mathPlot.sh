#!/usr/bin/python
from os import path
import matplotlib.pyplot as plt
from sys import argv

filename = argv[1]
if filename and path.isfile(filename):
	f = open(filename, "r")
try:
		#myvalues = [] #myvalues = [[],[]]
		i = 0
		#for line in f:
		myvalues = map(int, f.readline().split())
		plt.plot(myvalues)
		plt.ylabel('value')
		plt.xlabel('time')
		plt.show()
		f.close()
except KeyboardInterrupt:
	f.close()
	print "Pressed Ctrl+C. Bye, bye!"
	
