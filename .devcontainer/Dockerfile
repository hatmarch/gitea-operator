FROM quay.io/operator-framework/ansible-operator:v0.18.1

USER root

# NOTE: This image should never be pushed into a public registry as the username and password will get 
# exposed in the container (via inspect or through args)
ARG REDHAT_USER="redhat_user"
ARG REDHAT_PASS="redhat_pass"

# debugging
# RUN echo "REDHAT_USER is $REDHAT_USER and REDHAT_PASS is $REDHAT_PASS" > /tmp/arg.txt

RUN subscription-manager register  --username="$REDHAT_USER" --password="$REDHAT_PASS" --auto-attach

# RUN yum -y update
RUN yum install -y wget zsh jq git rsync

RUN subscription-manager unregister

# overwrite existing oc with the absolute newest version of the openshift client
RUN curl -L https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz | \
    tar -xvzf - -C /usr/bin/ oc && chmod 755 /usr/bin/oc

RUN wget https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl && \
    chmod 755 /usr/local/bin/kubectl

# Add the operator sdk
ENV OPERATOR_SDK_VERSION=v0.18.1
RUN curl -LO https://github.com/operator-framework/operator-sdk/releases/download/${OPERATOR_SDK_VERSION}/operator-sdk-${OPERATOR_SDK_VERSION}-x86_64-linux-gnu && \
    chmod +x operator-sdk-${OPERATOR_SDK_VERSION}-x86_64-linux-gnu && mkdir -p /usr/local/bin/ && \
    cp operator-sdk-${OPERATOR_SDK_VERSION}-x86_64-linux-gnu /usr/local/bin/operator-sdk && rm operator-sdk-${OPERATOR_SDK_VERSION}-x86_64-linux-gnu

COPY .zshrc /$HOME/.zshrc
COPY convert-kubeconfig-for-devcontainer.sh /$HOME/bin/convert-kubeconfig-for-devcontainer.sh

RUN chown -R ansible-operator $HOME && chmod -R +x $HOME/bin/

USER ansible-operator