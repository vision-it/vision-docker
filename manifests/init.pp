# Class: vision_docker
# ===========================
#
# Manages basic Docker installation
#
# Parameters
# ----------
#
# @param listen_address Docker TCP bind address
# @param listen_port Docker TCP bind port
# @param version To pin Docker CE Version
# @param registries List of Docker registries
#
class vision_docker (

  String  $listen_address,
  Integer $listen_port,
  String  $version,
  String  $userland_proxy,
  Optional[Hash] $registries = {},

) {

  file { '/etc/docker/':
    ensure  => directory,
  }
  ->file { '/etc/docker/daemon.json':
    ensure  => present,
    content => template('vision_docker/daemon.json.erb'),
  }

  class { '::docker':
    tcp_bind => "tcp://${listen_address}:${listen_port}",
    version  => $version,
    require  => File['/etc/docker/daemon.json']
  }

  class { '::docker::registry_auth':
    registries => $registries,
  }

  # pin docker-ce version if specific version wanted
  if $version != 'present' {
    file { '/etc/apt/preferences.d/docker-ce.pref':
      ensure  => present,
      content => template('vision_docker/docker-pin.erb'),
    }
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
    ensure   => running,
    enable   => true,
    name     => 'docker-system-prune.timer',
    provider => 'systemd',
    require  => [
      File['/etc/systemd/system/docker-system-prune.timer'],
      File['/etc/systemd/system/docker-system-prune.service'],
    ],
  }
}
