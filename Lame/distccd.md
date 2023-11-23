
### 3632/tcp open  distccd     syn-ack ttl 63 distccd v1 ((GNU) 4.2.4 (Ubuntu 4.2.4-1ubuntu4))

### like usual Let's google for this service and maybe see if there is any exploits.

- According to my Wikipedia search, `distcc` is a tool that accelerates code compilation by distributing the work across multiple computers connected via a network, resulting in faster compilation times.
  ![](../Attachemnts/Pasted%20image%2020231112143343.png)

- Let's now check if there are any possible exploits.

1. Using Google :
   - i found CVE in github : 
     ![](../Attachemnts/Pasted%20image%2020231112143618.png)

    -  here is the source code :
      ![](../Attachemnts/Pasted%20image%2020231112143713.png)




2.  Using Searchsploit : 
    -  Found a Command Execution : 
      ![](../Attachemnts/Pasted%20image%2020231112143840.png)
	  ![](../Attachemnts/Pasted%20image%2020231112144224.png)
	  -  Here is the Source Code:
	     ![](../Attachemnts/Pasted%20image%2020231112144323.png)

3. Using nmap :
   -  Searching For Scripts : 
		![](../Attachemnts/Pasted%20image%2020231112144529.png)

     -  Let's see source code : 
       	![](../Attachemnts/Pasted%20image%2020231112144700.png)

---

# Exploitation
###### Now we have three options: either we can use a script from Google (GitHub), a script we found using searchsploit, or Nmap scripts. In this case, let's use Nmap scripts since we've already used public scripts for FTP and searchsploit for Samba.

- When attempting to run the script with Nmap as per the usage instructions we founded in, we encountered an error. The issue arose because the script name should match either 'distcc-exec' or 'distcc-cve2004-2687' when executing the script.

    - so here is the error : 
	      ![](../Attachemnts/Pasted%20image%2020231112150432.png)
	- and here is the fix : 
		![](../Attachemnts/Pasted%20image%2020231112150740.png)

 - Now, all we have to do is establish a Netcat connection to connect back to our specific port (let's use 443 once more) and listen for the connection from our machine. This should be all and we need to gain shell access!
  - before execution :
	 ![](../Attachemnts/Pasted%20image%2020231112151324.png)
  - after execution : 
	  ![](../Attachemnts/Pasted%20image%2020231112151545.png)

######  and here we are we have a shell with demon as a user :D !

###### Now, we need to find a way to escalate our privileges to root. [[04-Prev Esc)

 ---
# Privilege Escalation
     

1. lets upgrade our shell : 
   ![](../Attachemnts/Pasted%20image%2020231112152327.png)

- Now, there are multiple methods for escalating our privileges. We could utilize the FTP backdoor while already inside the machine, as we suspect a universal firewall may block external connections. Additionally, we can perform local enumeration on the machine [[03-Local Enum), either manually or automatically using tools like LinPEAS.

2. Let's verify the functionality of our payload for the FTP backdoor.
![](../Attachemnts/Pasted%20image%2020231112153729.png)
-  As we can see, there are no active processes at the moment Listening on port 6200. Let's trigger the backdoor and check again.
 ![](../Attachemnts/Pasted%20image%2020231112154421.png)
- as we can see we have triggred the back door successfuly 

3. so now lets Just connect to it and see :).
   ![](../Attachemnts/Pasted%20image%2020231112154801.png)
- Yay! We are root :D.