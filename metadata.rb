name              "direnv"
maintainer        "Roman Heinrich"
license           "MIT"
description       "Configures direnv LWRPs"
long_description  IO.read(File.join(File.dirname(__FILE__), 'Readme.md'))
version           "0.1.0"

%w{ ubuntu debian }.each do |os|
  supports os
end
