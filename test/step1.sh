#!/bin/bash
set -x
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod +x get_helm.sh
./get_helm.sh
rm -rf get_helm.sh
curl -s https://api.github.com/repos/rancher/rke/releases/latest | grep download_url | grep linux-amd64 | cut -d '"' -f 4 | wget -qi -
chmod +x rke_linux-amd64
mv rke_linux-amd64 /usr/local/bin/rke
 curl -s https://api.github.com/repos/rancher/cli/releases/latest | grep download_url | grep linux-amd64 | cut -d '"' -f 4 | wget -qi -
gzip -d rancher-linux-amd64*.gz
tar -xf rancher-linux-amd64*.tar
mv rancher-*/rancher /usr/local/bin/
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl
add-apt-repository ppa:neurobin/ppa
apt update
apt install -y shc
apt install -y gcc

if ! [ -x "$(command -v rke)" > /dev/null 2>&1 ]; then
  echo "The rke binary is not installed nor in your PATH"
  exit 1
fi
