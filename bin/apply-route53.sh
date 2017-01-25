#!/bin/bash
cd $(dirname $0)/..
bundle exec roadwork -a --target '200.10.in-addr.arpa|nw.techconf.cookpad.com' "$@"
