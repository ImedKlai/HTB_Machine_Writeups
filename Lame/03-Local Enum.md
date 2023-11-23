##### we have already pwned the machine so let's maybe found other way's with some local enum!
- so first let's go to user makis and start from there!

## Manual Enum

##  1. nmap 


1. we cannot sudo -l  since we do not have the password
2. so let not waste more time and search for suid or sgid file owned by root!
![[Pasted image 20231112160022.png]]
- we found nmap and seems suspicious so lets check GTFOBins for prev esc method! 
![[Pasted image 20231112160202.png]]
- and i found this : 
  ![[Pasted image 20231112160334.png]]
  - so lets check if version apply's to that condetion!
    ![[Pasted image 20231112160513.png]]
 - so lets Exploit this : 
   ![[Pasted image 20231112160647.png]] 
   ###### Horayy! we are root! :D 

### 2. unrealircd 

1. I used `netstat` to inspect running services, looking for any suspicious activity. I discovered that the local machine was listening on port 6697, commonly associated with IRC. Considering potential vulnerabilities in this service that might lead to code execution, I proceeded with caution.
	![[Pasted image 20231112185732.png]]

2. checking for irc service and i did found it: 
	![[Pasted image 20231112185838.png]]
 3. searching for exploits with Searchsploit:
	 ![[Pasted image 20231112190144.png]]
 4. examining the exploit : 
    ![[Pasted image 20231112190354.png]]
 5. exploiting :
	 ![[Pasted image 20231112190607.png]]
	- As demonstrated, I directed the payload to the IRC service on the victim's machine and began listening on my end.
	 - after execution it took some seconds and here we Are Root Again :DD! 
	   ![[Pasted image 20231112190822.png]]
### and thats it thanks for following <3 <3 
    

## auto Enum


### Let's Use Linpeas !

- So LinPEAS is a Linux privilege escalation script that automates system enumeration, helping identify vulnerabilities and misconfigurations for potential privilege escalation on Linux systems. It simplifies the assessment and hardening of Linux security.

1. So Just need to somehow download it to victim machine and then execute it and wait for results.
	![[Pasted image 20231112193054.png]]
2. As demonstrated, we can utilize `curl` to retrieve and execute the content directly using the `sh` shell.