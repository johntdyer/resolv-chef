default[:resolv][:domain] = node.name.split(".")[1..-1].join(".")  # host.sub.domain.com => sub.domain.com
