# Class: vision_docker::swarm
# ===========================
#
# Manages Docker Swarm installation
#
# Parameters
# ----------
#
# @param manager_ip IP of Swarm manager
# @param join_token Swarm Join Token
# @param join Join a Swarm (bool)
# @param init Init a Swarm (bool)
#
class vision_docker::swarm (

  String $manager_ip,
  # join token determines if this node
  # will be a manager or worker
  String $join_token,
  String $ipaddress = $::ipaddress,
  String $hostname = $::hostname,
  # only for cluster initialization, you have been warned!
  Optional[Boolean] $join = true,
  Optional[Boolean] $init = false,

) {

  contain vision_docker

  docker::swarm { "swarm_${hostname}":
    init           => $init,
    join           => $join,
    advertise_addr => $ipaddress,
    listen_addr    => $ipaddress,
    manager_ip     => $manager_ip,
    token          => $join_token,
    require        => Service['docker'],
  }

}
