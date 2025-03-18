init_go() {
    echo "Installing Go:"
    GO_VERSION="1.24.1"
    # Download Go
    wget "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz"
    # Remove any existing Go installation
    rm -rf /usr/local/go
    # Extract Go to /usr/local
    tar -C /usr/local -xzf "go${GO_VERSION}.linux-amd64.tar.gz"
    # Set environment variables
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
    source ~/.bashrc
}

init_docker() {
    echo "Installing Docker:"
    # Add Docker's official GPG key:
    apt-get update
    apt-get install ca-certificates curl
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    chmod a+r /etc/apt/keyrings/docker.asc
    # Add the repository to Apt sources:
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt-get update
    # Install Docker packages 
    apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}


init_kubectl() {
    echo "Installing Kubectl:"
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
}

init_kind() {
    echo "Installing Kind:"
    # For AMD64 / x86_64
    [ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.27.0/kind-linux-amd64
    # For ARM64
    [ $(uname -m) = aarch64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.27.0/kind-linux-arm64
    chmod +x ./kind
    mv ./kind /usr/local/bin/kind
}

init_istio() {
    curl -L https://istio.io/downloadIstio | sh -
    cd istio-1.25.0
    export PATH=$PWD/bin:$PATH
    istioctl install
}

init_cluster() {
    echo "Create cluster w/ Kind"
    kind create cluster --name minerva

    # networking
    kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.2.0/standard-install.yaml
    kubectl apply -f gateway/gateway-api.yaml

    # minerva
    kubectl apply -f minerva/minerva-namespace.yaml
    kubectl apply -f minerva/minerva-deployment.yaml
    kubectl apply -f minerva/minerva-service.yaml
    kubectl apply -f minerva/minerva-httproute.yaml
}

echo "Installing dependencies."
init_go()
init_docker()
init_kubectl()
init_kind()
init_istio()
init_cluster()