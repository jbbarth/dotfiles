#!/bin/bash

cd
echo "* Downloading doc"
wget -P doc http://railsapi.com/doc/authlogic-v2.1.3_eventmachine-v0.12.8_hpricot-v0.8_nokogiri-v1.4.1_rack-v1.1_rails-v2.3.5_rspec-v1.3.0_rspecrails-v1.3.2_ruby-v1.8_sinatra-v1.0_thin-v1.2.7_webrat-v0.7.1/rdoc.zip
cd doc
unzip rdoc.zip
rm -f rdoc.zip
