# Class: vision_docker
# ===========================
#
# Parameters
# ----------
#
# [*listen_address*]
# Listen Address.
# Default: 0.0.0.0
#
# [*listen_port*]
# Listen Port.
# Default: 2375
#
# [*compose_version*]
# Docker-Compose version.
# Default: 1.6.2
#
# Examples
# --------
#
# @example
# contain ::vision_docker
#
class vision_docker (

  String  $listen_address,
  Integer $listen_port

) {

  class { '::docker':
    tcp_bind => "tcp://${listen_address}:${listen_port}"
  }

  # Job for cleaning up unused Images
  file { '/etc/systemd/system/docker-system-prune.service':
    ensure  => present,
    content => template('vision_docker/docker-system-prune.service.erb'),
    notify  => Service['docker-system-prune'],
  }

  file { '/etc/systemd/system/docker-system-prune.timer':
    ensure  => present,
    content => template('vision_docker/docker-system-prune.timer.erb'),
    notify  => Service['docker-system-prune'],
  }

  service { 'docker-system-prune':
    ensure  => running,
    enable  => true,
    name    => 'docker-system-prune.timer',
    require => [
      File['/etc/systemd/system/docker-system-prune.timer'],
      File['/etc/systemd/system/docker-system-prune.service'],
    ],
  }

}
