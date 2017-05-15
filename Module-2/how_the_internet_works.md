#How The Internet Works

##Objectives
	
	- Understand that the internet is simply a wire
	- Understand what a server is
	- Understand what a client is
	- Understand what a Internet Protocol (IP) address is
	
##Roadmap

###History

	Initial concept of packet networking led to the development of ARPANET, which is the first network to use Internet protocol

	The first messafe was sent by Professor Leonard Kleinrock's laboratory at UCLA to Standford

###Servers

	Servers are special computers connected directly to the Internet. 

	Web pages are files on that hard-drive
	
	Domain names are simply aliases of the IP address
	
	
###Clients

	Your computer is a client. So is your tablet. They are connected through an Internet Service Provider (ISP)
	
<img src="http://techzil.com/wp-content/uploads/2012/11/an-extensive-overview-of-proxy-servers-13441.png" />


###Activity
***

	Explain to the person next to you the difference in client and server

###Emails

	When sending an email, the email gets sent through your ISP to the Internet and into the server (gmail, yahoo, aol, etc.). When the client visits the server, they can view the email

###Sending of information

	When an email, image, or webpage gets requested, the Internet breaks them down into smaller pieces called packets and sent. They are then reassembled to form what it was originally. 

So when you hear about bandwidth, its simply the data transfer rate (amount of data sent from point A to point B in a time period)

This is measured in bits per second (bps) / megabits per second (mbps) / gigabits per second (gbps)

###IP Address 

	Everything connected directly or indirectly to the Internet has an IP address! (servers, computers, cellphones)
	
	Routers exist where two or more parts of the Internet intersect. They direct the packets around the Internet. 


Let's look at the world's first webpage:

###[The world's first webpage:](http://info.cern.ch/hypertext/WWW/TheProject.html)

###How to check if a site is alive

	ping http://info.cern.ch/hypertext/WWW/TheProject.html

###How to be a Browser

+ Given a domain name, a name server search is performed on the domain name to get the IP address:

		nslookup google.com

+ If there are several IP addresses associated with the domain, the name server chooses one at random and sends it to your browser.

+ We can see the name server sending a random IP by
	
		traceroute google.com

+ Now, the root resource is requested. Port 80 is the standard HTTP port. To obtain the HTML code, we send an HTTP request (GET / HTTP/1.1) to the IP address. Press Return twice after typing in the below:

		curl https://www.google.com

##Other Terminal Commands

###Domain Registration Registry Search

View the public registration information for a given domain name:

	whois flatironschool.com

###Name Server Search
	
View all of the name server entries for a domain name (or subdomain+domain) by using dig. (A - IP address to route to. MX - Mail exchange server where to route emails.)

	dig flatironschool.com any
	
###Activity
***
Spend 5 minutes writing down what you learned today. Then share it with the person next to you!

###Questions

- What is the purpose of a router?
- How is information sent over the Internet?
- Does everything connected to the Internet (directly and indirectly) have an IP address?
- How are IPs linked to domain names?