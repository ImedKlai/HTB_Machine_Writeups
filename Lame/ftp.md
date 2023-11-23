# recon

### ftp : 21/tcp   open  ftp         syn-ack ttl 63 vsftpd 2.3.4

anonymous connection successful, but nothing was found :
![[Pasted image 20231107163015.png]]

### googling exploits for ftp version (you can use searchsploit): 
-  googling for version vsftpd 2.3.4 exploit
 ![[Pasted image 20231107165104.png]]
- I discovered an exploit for the vsftpd 2.3.4 backdoor on Exploit-DB! 
 ![[Pasted image 20231107164340.png]]
 
 - The backdoor can be accessed by using a 6-character username ending with ":)" and any random password and should be 16 characters. This backdoor allows access to a specific port, which is located on port 6200.
 ![[Pasted image 20231107164357.png]]

---
# Exploitation

-  so I'v tried to do everything manually exactly like the screenshots bellow !
![[Pasted image 20231107195636.png]]

- After conducting all the necessary steps, I have come to the conclusion that no connection was established, which may indicate the possibility of a firewall blocking port 6200,(out bound).
-  So maybe we can use this technique from within the machine as Prev Esc.
![[Pasted image 20231107200250.png]]

- Subsequently, I'v adjusted my approach and redirected my focus towards the [[Samba]] service, with the aspiration of potentially applying this method locally for privilege escalations [[04-Prev Esc]].