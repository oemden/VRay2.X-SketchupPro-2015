#Deploy Vray2.x for Sketchup Pro 2015 (Mac) with Remote Server Licence File.

**This script will Create an installer .pkg to deploy Vray2.x for Sketchup2015 Using a Licence Server.**
 

It works with munki. And should work with ARD or any deployment tool.

You'll need : 

- Sketchup Pro 2015 for Mac.
- a Vray2.x for Sketchup Volume Licence & Vray2.x Licence Server


###Edit the script with:

####The Licence Server information :

Your Main Server IP(s), Server Port(s), Server User and password if needed.

####VRay Installer information :

The Vray dmg name ( for example : vray_adv_20025539_sketchup_2015_osx_x64.dmg) 

and the VRay Volume name ( for example "V-Ray for SketchUp" )

####Wanted .pkg version, bundle identifier and pkg name.

Specify your desired pkg version. ( for example 2.00.25539 ), your BundleIdentifier and pkgname.

**Then run the script to create your installer package.**

Tested on 10.10.x Clients
