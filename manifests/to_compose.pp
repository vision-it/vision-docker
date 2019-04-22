define vision_docker::to_compose (
  Hash $compose,
  String $path = '/vision/data/swarm',
  String $owner = 'root',
  String $group = 'root',
  String $mode = '0600',
  ) {

  file { "${path}/${title}.yaml":
    ensure  => present,
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    content => inline_template("# This file is managed by Puppet\n<%= @compose.to_yaml %>"),
  }
}
