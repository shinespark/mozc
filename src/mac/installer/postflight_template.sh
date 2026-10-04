#!/bin/sh
CONSOLE_USER=`/usr/bin/stat -f%Su /dev/console`
/usr/bin/sudo -u $CONSOLE_USER /usr/bin/killall yuzKeyConverter > /dev/null
/usr/bin/sudo -u $CONSOLE_USER /usr/bin/killall yuzKeyRenderer > /dev/null
/usr/bin/sudo -u $CONSOLE_USER /usr/bin/killall yuzKey > /dev/null
/usr/bin/true
