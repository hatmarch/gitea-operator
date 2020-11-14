set -eu

declare CFG=$1
echo "Adapting ${CFG} for suitable in container kubeconfig"

sed -i -e "s#/Users/${HOST_USER}#${HOME}#g" $CFG