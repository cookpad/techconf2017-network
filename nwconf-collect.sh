#!/bin/bash
cd $(dirname $0)
set -e
set -x
for x in gw sw sw2; do
  echo -e 'term len 0\n\nshow running-config\n\nexit' | ssh -T ${x}.mgmt.nw.techconf.cookpad.com | sed -e "s/\r//g" -e "s/ \+$//" | sed -e '1,/^Current configuration :/ d' -e '/^[a-zA-Z0-9-]\+# *$/,$ d'> nwconf/${x}.txt
  # 
done

./nwconf-filter.sh
