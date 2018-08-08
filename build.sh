set -ex
# SET THE FOLLOWING VARIABLES
# docker hub username
USERNAME=goodes
# image name
IMAGE=sphinx-build
docker build --rm -t $USERNAME/$IMAGE:latest .
