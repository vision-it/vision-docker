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

