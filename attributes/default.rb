default[:resolv][:domain] = node.name.split(".")[1..-1].join(".")  # host.sub.domain.com => sub.domain.com

default[:resolv][:timeout]   =  1
default[:resolv][:attempts]  =  2
