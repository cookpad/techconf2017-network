#!/bin/bash
cd $(dirname $0)
sed -E -i.bak \
  -e 's/^([[:space:]]*enable secret [0-9]).*$/\1 MASK/' \
  -e 's/^([[:space:]]*username .+ password [0-9]).*$/\1 MASK/' \
  -e 's/^([[:space:]]*snmp-server community ).+( .*)$/\1MASK\2/' \
  -e 's/^([[:space:]]*pre-shared-key.* key).*$/\1 MASK/' \
  nwconf/*.txt
rm -v nwconf/*.bak
