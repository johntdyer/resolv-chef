#
# Cookbook Name:: resolv
# Recipe:: default
#
# Copyright 2012, Voxeo Labs ©2011
#
# All rights reserved - Do Not Redistribute
#


# If there are no 'options' block in resolv.conf we want to add it
if node[:resolv][:options_enabled]
   script "add options to resolv.conf if missing" do
     interpreter "bash"
     user "root"
     cwd "/etc"
     code <<-EOF
       echo "options rotate timeout:#{node[:resolv][:timeout]} attempts:#{node[:resolv][:attempts]}" >> resolv.conf
     EOF
     not_if "grep options /etc/resolv.conf"
   end
end

ruby_block "edit resolv conf" do
  if node[:resolv][:domain]
    block do
      rc = Chef::Util::FileEdit.new("/etc/resolv.conf")
      rc.search_file_replace_line(/^search/, "search #{node[:resolv][:domain]} #{node[:resolv][:domain].dup.split(".").last(2).join('.') if node[:resolv][:domain].dup.split(".").count>2 && node[:resolv][:search_additional_domain]}")
      rc.search_file_replace_line(/^domain/, "domain #{node[:resolv][:domain]}")
      if node[:resolv][:options_enabled]
         rc.search_file_replace_line(/^options/, "options rotate timeout:#{node[:resolv][:timeout]} attempts:#{node[:resolv][:attempts]}")
      end
      rc.write_file
    end
  end
end
