#!/bin/bash

: Add ubuntu user to adm and root groups using sed
sed -i -r -e '/ubuntu/! s/^(root|adm):.*\w$/\0,/'  `# add comma if needed` \
	  -e '/ubuntu/! s/^(root|adm):.*/\0ubuntu/' /etc/group

: Change timezone to Europe/Berlin in /etc/timezone using sed

: Change timezone to Europe/Minsk using bash shell utilites and apply it using system commands
