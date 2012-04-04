#
# Cookbook Name:: resolv
# Recipe:: default
#
# Copyright 2012, Voxeo Labs ©2011
#
# All rights reserved - Do Not Redistribute
#

node.set_unless[:resolv][:domain] = node.fqdn.split(".")[1..-1].join(".")  # host.sub.domain.com => sub.domain.com

ruby_block "edit resolv conf" do
  if node[:resolv][:domain]
    block do
      rc = Chef::Util::FileEdit.new("/etc/resolv.conf")
      rc.search_file_replace_line(/^search/, "search #{node[:resolv][:domain]}")
      rc.search_file_replace_line(/^domain/, "domain #{node[:resolv][:domain]}")
      rc.write_file
    end
  end
end
