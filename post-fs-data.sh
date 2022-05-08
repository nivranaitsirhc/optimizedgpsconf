#!/system/bin/sh
# set ownership
chown -R 0:0 $GPSCONFVENDOR

[ "$(getenforce)" = "Enforcing" ] || exit 0

GPSCONFVENDOR=/system/vendor/etc/gps.conf

default_selinux_context=u:object_r:vendor_configs_file:s0
selinux_context=

# Detect the GPS Config is located.
if [[ -f $GPSCONFVENDOR ]];then
    selinux_context=$(ls -Zd $GPSCONFVENDOR | awk '{print $1}')
fi

if [ -n "$selinux_context" ] && [ "$selinux_context" != "?" ]; then
    chcon -R $selinux_context $GPSCONFVENDOR
else
    chcon -R $default_selinux_context $GPSCONFVENDOR
fi