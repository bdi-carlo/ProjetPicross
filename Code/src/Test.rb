require 'rbconfig'

@os = RbConfig::CONFIG['host_os']

puts @os.downcase
