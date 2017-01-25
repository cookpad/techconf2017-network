#!/bin/bash
cd $(dirname $0)/..
bundle exec piculet -f Groupfile -a --ec2s vpc-deadbeef "$@"
