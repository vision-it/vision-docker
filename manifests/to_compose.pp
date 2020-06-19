# Define: vision_docker::to_compose
# ===========================
#
# Docker-Compose File Resource
#
# Parameters
# ----------
#
# @param compose Content of Docker-Compose File
# @param path Directory in which the file is created
#
define vision_docker::to_compose (

  Hash $compose,
  String $path  = '/vision/data/swarm',
  String $owner = 'root',
  String $group = 'root',
  String $mode  = '0600',

) {

  # ensure target directory exists
  if !defined(File[$path]) {
    file { $path:
      ensure => directory,
      mode   => '1750',
    }
  }

  file { "${path}/${title}.yaml":
    ensure  => present,
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    content => inline_template("# This file is managed by Puppet\n<%= @compose.to_yaml %>"),
  }

}
