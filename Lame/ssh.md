### 22/tcp   open  ssh         syn-ack ttl 63 OpenSSH 4.7p1 Debian 8ubuntu1 (protocol 2.0)



- lets see /root/.ssh prem: 
	  ![[Pasted image 20231112163804.png]]

- We do know that there is an old openSSL cve that can allow us to predict the private key based on a weekness of the pub key.
  
1. Let's google it and see : 
   ![[Pasted image 20231112162720.png]]

![[Pasted image 20231112162745.png]]
- so lets clone this repo and see! 

# Exploitation


1. cloning the repo:
	![[Pasted image 20231112161536.png]]
	 ![[Pasted image 20231112162919.png]]
  
 2. After cloning, I navigated to the common keys directory and extracted the 'rsa.bz2' file, as it's commonly used.
     ![[Pasted image 20231112164355.png]]
	![[Pasted image 20231112170033.png]]
 - As there are numerous public/private key pairs, we need to determine which of these corresponds to the key we obtained from '/root/.ssh/authorized_keys.' This will allow us to retrieve its private key and establish a root-level SSH connection.
	 ![[Pasted image 20231112170319.png]]

3. Let's utilize `grep` to locate the key and its corresponding pair.
```
grep -lr <key here>
```

- and Yay! we found match : 
	  ![[Pasted image 20231112170819.png]]
4. so now let's use the pub key file name without .pub extension as our prv key to connect via ssh!
   ![[Pasted image 20231112192601.png]]
- And Yay! again xd, Here we are root again ! :D 