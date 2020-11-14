FROM quay.io/mhildenb/operator-builder:latest

COPY .zshrc /home/jboss/.zshrc
COPY convert-kubeconfig-for-devcontainer.sh /home/jboss/bin/convert-kubeconfig-for-devcontainer.sh
USER root
RUN chown -R jboss /home/jboss && chmod -R +x /home/jboss/bin/

USER jboss