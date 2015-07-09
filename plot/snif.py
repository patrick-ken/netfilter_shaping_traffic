import os
from time import sleep
import socket, sys
from struct import *

#Convert a string of 6 characters of ethernet address into a dash separated hex string
def eth_addr (a) :
  b = "%.2x:%.2x:%.2x:%.2x:%.2x:%.2x" % (ord(a[0]) , ord(a[1]) , ord(a[2]), ord(a[3]), ord(a[4]) , ord(a[5]))
  return b

#create a AF_PACKET type raw socket (thats basically packet level)
#define ETH_P_ALL    0x0003          /* Every packet (be careful!!!) */
try:
	s = socket.socket( socket.AF_PACKET , socket.SOCK_RAW , socket.ntohs(0x0003))
except socket.error , msg:
	print 'Socket could not be created. Error Code : ' + str(msg[0]) + ' Message ' + msg[1]
	sys.exit()


rwnd_file = open('rwnd.txt', 'w+')
speed_file = open('speed.txt', 'w+')
f = open('/sys/class/net/eth1/statistics/rx_bytes', 'r')
RXPREV = int(f.readlines()[0])
f.close()
flag = 0
source_ip = '1.1.1.1'

try:
	# receive a packet
	while True:
		packet = s.recvfrom(65565)
	
		#packet string from tuple
		packet = packet[0]
	
		#parse ethernet header
		eth_length = 14
	
		eth_header = packet[:eth_length]
		eth = unpack('!6s6sH' , eth_header)
		eth_protocol = socket.ntohs(eth[2])

		#Parse IP packets, IP Protocol number = 8
		if eth_protocol == 8 :
			#Parse IP header
			#take first 20 characters for the ip header
			ip_header = packet[eth_length:20+eth_length]
		
			#now unpack them :)
			iph = unpack('!BBHHHBBH4s4s' , ip_header)

			version_ihl = iph[0]
			version = version_ihl >> 4
			ihl = version_ihl & 0xF

			iph_length = ihl * 4

			ttl = iph[5]
			protocol = iph[6]
			s_addr = socket.inet_ntoa(iph[8]);

			#TCP protocol
			if protocol == 6 and s_addr == source_ip:
				rate = open('/sys/class/net/eth1/statistics/rx_bytes', 'r')
				t = iph_length + eth_length
				tcp_header = packet[t:t+20]

				#now unpack them :)
				tcph = unpack('!HHLLBBHHH' , tcp_header)
				if flag == 2:
					window = tcph[6]
					rwnd_file.write(str(window) + ' ')
				else:
					flag += 1

				RX = int(rate.readlines()[0])
				rate.close()
				speed_file.write(str(int((RX - RXPREV)/1000)) + ' ')

				RXPREV = RX
				sleep(1)
			
except KeyboardInterrupt:
	rwnd_file.seek(-1, os.SEEK_END)
	rwnd_file.truncate()

	speed_file.seek(-1, os.SEEK_END)
	speed_file.truncate()
