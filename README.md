docker-cibuild
==============

Container for automated building + testing of Drupal sites.

- container based on boran/drupal (for Ubuntu 14.04 + drupal dependancies)
- with SSH server (as a slave to Jenkins)
- with build tools for Drupal


The build scripts are to be installed in /home/builder, which come from a separate repo https://github.com/Boran/drupal-ci.

todo 
- doc (see https://github.com/Boran/drupal-ci).

Creating the docker image:
docker build -t boran/cibuild .
