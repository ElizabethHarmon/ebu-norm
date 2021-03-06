#!/bin/bash
# Installer for ebu-norm, tp-norm and ebu-scan
# Copyright © 2021 Elizabeth Harmon

echo "This script will install batch normalizer/scanner scripts to usr/local/bin"
read -p "Do you wish to continue?" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "Making scripts executable..."
	sleep 1
	chmod +x ebu-norm tp-norm ebu-scan ebu-plot
	echo "Copying scripts to usr/local/bin..."
	sleep 1
	cp ebu-norm tp-norm ebu-scan ebu-plot ebu-plot.psl /usr/local/bin
	echo "Done!!"
fi
