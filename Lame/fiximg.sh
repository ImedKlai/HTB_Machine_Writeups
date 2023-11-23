#!/bin/bash

for file in *.md;do
    sed -ri 's|(\!\[\[Pasted\ image\ )|![](../Attachemnts/Pasted%20image%20|g' "$file";
    sed -ri 's|(\]\])|)|g' "$file";
done;

# Consider images under /Attachments folder previously.
# old image link   -  ![[Pasted image 20220109203352.png]] 
# new image link - ![](../Attachments/Pasted%20image%2020220122124535.png)
