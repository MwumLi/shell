#! /bin/bash
export PS4='$0.$LINENO+'
set -x
echo 'PS4 demo script'
ls -l /etc/|wc -l
du -sh ~
