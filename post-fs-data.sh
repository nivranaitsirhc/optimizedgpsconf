#!/system/bin/sh
# define local
GPSCONFVENDOR=/system/vendor/etc/gps.conf
GPSCONFMODIR=$MODIR$GPSCONFVENDOR

# set ownership
chown -R 0:0 $GPSCONFVENDOR

[ "$(getenforce)" = "Enforcing" ] || exit 0

# default se context for gps conf
default_selinux_context=u:object_r:vendor_configs_file:s0
selinux_context=

# get the original se context if present
if [[ -f $GPSCONFVENDOR ]];then
    selinux_context=$(ls -Zd $GPSCONFVENDOR | awk '{print $1}')
fi

# set proper se context
if [ -n "$selinux_context" ] && [ "$selinux_context" != "?" ]; then
    chcon -R $selinux_context $GPSCONFMODIR
else
    chcon -R $default_selinux_context $GPSCONFMODIR
fi