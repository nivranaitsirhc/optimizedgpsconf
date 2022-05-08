#!/bin/bash
rm -f ./install.zip
zip install.zip common/* META-INF/* system/vendor/etc/* customize.sh LICENSE module.prop README.md uninstall.sh
git add install.zip update.json changelog.md module.prop
