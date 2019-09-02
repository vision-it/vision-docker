# Dirty hack to make Debian Buster builds work
# Currently (August 2019) there is no puppet-agent in the puppetlabs-release Repo for Buster
# So, we use the Stretch repo until that is fixed
sed -i 's/\/tmp\/puppet\.deb #{remote}/\/tmp\/puppet\.deb http:\/\/apt.puppet.com\/puppet5-release-stretch.deb/g' $(find . -type f -name foss_utils.rb)
