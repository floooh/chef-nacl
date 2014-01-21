#
# Cookbook Name:: nacl
# Recipe:: default
#
# Copyright (C) 2014 Andre Weissflog
# 
# All rights reserved - Do Not Redistribute
#
include_recipe 'apt'
include_recipe 'python'
include_recipe 'build-essential'

user = "#{node['nacl']['user']}"
group = "#{node['nacl']['group']}"
bundle = "#{node['nacl']['bundle']}"
url = "#{node['nacl']['url_prefix']}/nacl_sdk.zip"
rootpath = "#{node['nacl']['rootpath']}"
home = "/home/#{user}"

# required packages (unzip, and 32-bit runtime libs)
package "unzip"
package "libc6:i386"
package "libstdc++6:i386"

# install chrome
apt_repository "chrome" do
    uri "http://dl.google.com/linux/chrome/deb/"
    distribution "stable"
    components ["main"]
    key "https://dl-ssl.google.com/linux/linux_signing_key.pub"
    action :add
end
package "google-chrome-stable"

# make sure the sdk root directory exists
directory "#{rootpath}" do
    owner "#{user}"
    group "#{group}"
    action :create
end

# get the nacl_sdk.zip
remote_file "#{rootpath}/nacl_sdk.zip" do 
    source "#{url}"
    owner "#{user}"
    group "#{group}"
    notifies :run, "bash[unpack]", :immediately
end

# unzip the sdk
bash "unpack" do
    user "#{user}"
    group "#{group}"
    cwd "#{rootpath}"
    code "/usr/bin/unzip nacl_sdk.zip"
    action :nothing
end

# ...and run the update operation which downloads the actual SDK files
bash "update" do
    user "#{user}"
    group "#{group}"
    cwd "#{rootpath}/nacl_sdk"
    code "./naclsdk update #{bundle}"
end

# add NACL_ROOT to .bash_profile
bash "update_profile" do
    cwd "#{home}"
    user "#{user}"
    group "#{user}"
    code <<-EOH
        echo "export NACL_ROOT=#{rootpath}/nacl_sdk/#{bundle}" >>.bash_profile
    EOH
    not_if "test -e .bash_profile && grep -q NACL_ROOT .bash_profile"
end

