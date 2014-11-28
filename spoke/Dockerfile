# Spoke Dockerfile for sshd

FROM            radial/spoke-base:latest
MAINTAINER      Brian Clements <radial@brianclements.net>

# Install packages
ENV             DEBIAN_FRONTEND noninteractive
RUN             apt-get -q update && apt-get -qyV install \
                    openssh-server &&\
                apt-get clean

# Login fix. Otherwise user is kicked off after login
RUN             sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Replace the default host keys with a new set on every build.
RUN             rm /etc/ssh/ssh_host_* &&\
                dpkg-reconfigure openssh-server

# To enable SSH into this container, supply your GitHub username for $GH_USER
# with `ENV GH_USER` in your Spoke Dockerfile and the same public keys used for
# GitHub will be inserted into your container. This is 'secure' in that use of
# public keys are always secure, but it is not the wisest strategy to use the
# same key-pair for multiple venues (server cluster, public website, etc.). More
# robust key management is a feature for a future date. For now, this suffices
# for prototyping and development on small clusters.
#
# For the security minded, the default '/__NULL__/' value fails the syntax test
# in `ssh-import-id` and never reaches the github API. This is safer then
# sending an "unlikely" value to the API and hoping it doesn't match anything.
ENV             GH_USER
RUN             mkdir -p /var/run/sshd

# Configure Spoke settings
ENV             SPOKE_NAME sshd
ENV             SPOKE_CMD ssh

COPY            /get_public_keys.sh /get_public_keys.sh
