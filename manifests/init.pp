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
  Integer $listen_port,
  String  $compose_version,
) {

  class { '::docker':
    tcp_bind     => "tcp://${listen_address}:${listen_port}",
  }

  class { '::docker::compose':
    version => $compose_version
  }
}
