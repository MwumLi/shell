#!/bin/bash  

exec 4>test
exec 5>cc
exec 5>&4

echo "henghenggaag" >& 5
