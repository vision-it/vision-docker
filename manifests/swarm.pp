# Class: vision_docker::swarm
# ===========================
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
