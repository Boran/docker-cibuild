docker-cibuild
==============

Container for automated building + testing of Drupal sites.

- based on boran/drupal (Ubuntu 14.04 + drupal dependancies)
- with SSH server (as a slave to Jenkins)
- build tools for Drupal
- testing tool: Codeception


The build scripts are to be installed in /home/builder, which come from a separate repo https://github.com/Boran/drupal-ci.

Doc 
- see https://github.com/Boran/drupal-ci

Creating the docker image:
docker build -t boran/cibuild .
