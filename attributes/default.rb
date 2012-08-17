default[:resolv][:domain] = node.name.split(".")[1..-1].join(".")  # host.sub.domain.com => sub.domain.com
default[:resolv][:search_additional_domain] = true # Whether search field should have a 2nd domain in it, ie sub.domain.com and domain.com, or if false just the above :domain ie sub.domain.com
default[:resolv][:timeout]   =  1
default[:resolv][:attempts]  =  2
