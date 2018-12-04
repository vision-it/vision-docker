# vision-docker

[![Build Status](https://travis-ci.org/vision-it/vision-docker.svg?branch=production)](https://travis-ci.org/vision-it/vision-docker)


## Usage

Include in the *Puppetfile*:

```
mod vision_docker:
    :git => 'https://github.com/vision-it/vision-docker.git,
    :ref => 'production'
```

Include in a role/profile:

```puppet
contain ::vision_docker
```

## Swarm Mode

### How to initialize a new Swarm cluster

For the **first** node:

```yaml
vision_docker::swarm::manager_ip: 10.0.2.15 # ip of first node
vision_docker::swarm::join: false
vision_docker::swarm::init: true
vision_docker::swarm::join_token: ''
```

Afterwards, `docker node ls` should not return an error but show only a single node in the cluster.

Next, remove the `join` and `init` directives from above hiera config.
Generate join tokens for worker and manager nodes with `docker swarm join-token (worker|manager)` and add them to hiera (take note whether the token is for a worker or manager node!):

```yaml
vision_docker::swarm::manager_ip: '10.0.2.15'
# manager join token
vision_docker::swarm::join_token: 'SWMTKN-1-4tomhadkq4b9th3ktlc70uri9asx60ajh32lzwijzhwhryspj1-171vp8ra2p00wgipnlnuz172v'
```

Also add a manager join token for your initial manager node, so in case he loses the connection he can automatically re-join the swarm.

In general it makes sense to store the join token on a higher level, such as `hiera/roles` instead of `hiera/nodes`, so all Nodes have access to the same join tokens.

Don't forget to configure your firewall to allow ports 2377/TCP, 7946/TCP/UDP and 4789/UDP!

```yaml
vision_firewall::system_rules:
  '123 allow docker swarm tcp from tst02':
    proto: 'tcp'
    source: '192.168.42.3'
    action: 'accept'
    dport: [2377, 7946]
  '123 allow docker swarm udp from tst02':
    proto: 'udp'
    source: '192.168.42.3'
    action: 'accept'
    dport: [4789, 7946]
```

Reference: https://docs.docker.com/engine/swarm/swarm-tutorial/
