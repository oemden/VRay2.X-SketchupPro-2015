#!/bin/bash
#
# oem at oemden dot com - 20151116
#
## Install Vray for Sketchup & Install remote Server File xml
#
# Create an installer pkg to deploy Vray for Sketchup Using a Licence Server
# 
# ===================== Edit Information below =============================
#
# ================ The Licence Server information :
ServerIP0="192.168.200.200" # Main Server IP
ServerPort0="30304" # depends on your setup
#ServerIP1="" # uncomment if needed - depends on your setup
ServerPort1="30304" # depends on your setup
#ServerIP2="" # uncomment if needed - depends on your setup
ServerPort2="30304" # depends on your setup
#ServerUser="" # uncomment if needed - depends on your setup
#ServerUserpwd="" # uncomment if needed - depends on your setupr

# ================ VRay Installer information :
VRay_dmg="vray_adv_20025539_sketchup_2015_osx_x64.dmg" # ( DMG image name - at the time of writing).
VolName="V-Ray for SketchUp" # ( VRay Installer Volume Name - at the time of writing).

# ================ Your desired Installer Name :
version="2.00.25539" ## Edit accordingly to the VRay Installer - ( v2.00.25539 at the time of writing).
identifier="com.example.int.pkg.installVray.${version}.Sketchup2015" ## pkg bundleidentifier
pkgname="InstallVray.${version}.ForSketchup2015LicenceServer.pkg" ## pkg name
# ================================ EDIT END ================================

InstallTmpDir="root/private/tmp/VRAY2XSKETCHUP"
my_path=`dirname "$0"`

cd "$my_path"

function mount_Volume {
	if [[ ! -f "${VRay_dmg}" ]] ; then
		echo " Missing Installer disk Image "
		exit 1
	fi
	echo "mounting disk image"
	hdiutil attach -owners on "${VRay_dmg}" -noverify -nobrowse
}

function eject_Volume {
	hdiutil eject "${VolName}" -force 2>/dev/null
}

function check_Volume_mounted {	
	if [[ ! -d "/Volumes/${VolName}" ]] ; then
		echo " Missing Volume "
		exit 1
	fi
}

function create_rootDir {
	mkdir -p "${InstallTmpDir}"/ChaosGroup_xml_srv
}

function copy_VrayInstaller {
	ditto -rsrcFork "/Volumes/${VolName}/VRayForSketchUp-"*.app/Contents/MacOS "${InstallTmpDir}"/MacOS
}

function write_net_license {
	printf "<VRLClient>\n<LicServer>\n<Host>${ServerIP0}</Host>\n<Port>${ServerPort0}</Port>\n<Host1>${ServerIP1}</Host1>\n<Port1>${ServerPort1}</Port1>\n<Host2>${ServerIP2}</Host2>\n<Port2>${ServerPort2}</Port2>\n<!Proxy></!Proxy>\n<!ProxyPort>0</!ProxyPort>\n<User>${ServerUser}</User>\n<Pass>${ServerUserpwd}</Pass>\n</LicServer>\n</VRLClient>" > "${InstallTmpDir}"/ChaosGroup_xml_srv/vrlclient2.xml
}

function create_pkg {
	pkgbuild --root ./root --scripts ./scripts --version "${version}" --identifier "${identifier}" "${pkgname}"
}

function cleanup {
	rm -Rf ./root
}

function do_it {
	clear
	eject_Volume
	mount_Volume
	check_Volume_mounted
	create_rootDir
	copy_VrayInstaller
	write_net_license
	sleep 5
	create_pkg
	eject_Volume
	cleanup
}

do_it

exit 0
