### Description ###

This is a Chef cookbook to setup a Google Native Client build environment on Linux (only Ubuntu/Debian flavour so far).

What happens under the hood:

* makes sure that the following packages are installed: "unzip", "libc6:i386", "libstdc++6:i386"
* install google-chrome-stable package from "http://dl.google.com/linux/chrome/deb"
* install the nacl-sdk stub into ~/nacl-sdk/nacl_sdk
* install the pepper_canary bundle
* setup NACL_ROOT environment variable point to ~/nacl-sdk/nacl_sdk/pepper_XXX in .bash_profile

### Requirements ###
#### Platform: ####

* Ubuntu/Debian

#### Dependencies ####

* apt
* python
* build-essential

### Attributes ###
#### Default recipe attributes: ####

* ```default['nacl']['user'] = "vagrant"```: the user for which to install the NaCl SDK
* ```default['nacl']['group'] = "vagrant"```: the group to use for file permissions
* ```default['nacl']['rootpath'] = '/home/vagrant/nacl-sdk'``` where to install the NaCl SDK
* ```default['nacl']['url_prefix'] = 'http://storage.googleapis.com/nativeclient-mirror/nacl/nacl_sdk'``` where to find the SDK stub
* ```default['nacl']['bundle'] = 'pepper_canary'```: what pepper bundle to install

### Author ####
Author:: Andre Weissflog (floooh@gmail.com)
