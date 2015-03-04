docker-cibuild
==============

Container for automated building + testing of Drupal sites.

- container based on boran/drupal (for Ubuntu 14.04 + drupal dependancies
- with SSH server (as a slave to Jenkins)
- with build tools for Drupal


The build scripts are to be installed in /home/builder, whicho come from a separate repo.

todo 
- put drupal-ci build scripts on github
- doc!


Creating the docker image:
docker build -t boran/cibuild .
