# encoding: UTF-8
#
#   Cookbook Name: nacl
#   Attributes: default
#

# user, group and installation directory
default['nacl']['user'] = 'vagrant'
default['nacl']['group'] = 'vagrant'
default['nacl']['rootpath'] = '/home/vagrant/nacl-sdk'

# where to find the nacl_sdk.zip updater stub
default['nacl']['url_prefix'] =
  'http://storage.googleapis.com/nativeclient-mirror/nacl/nacl_sdk'

# what NaCl SDK bundle to use
default['nacl']['bundle'] = 'pepper_canary'
