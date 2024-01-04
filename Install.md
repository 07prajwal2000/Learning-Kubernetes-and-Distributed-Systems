# Install and Run K0S kubernetes in EC2

## I used 2 EC2 instances
- 1 for control plane
- 1 for worker

#### Download and Install K0S binary
```bash
curl -sSLf https://get.k0s.sh | sudo sh
```

### Install K0S Control Plane
- Generate Config file: 
    ```bash
    k0s default-config > k0s.yml
    ```
- Install the node as control plane: 
    ```bash
    sudo k0s install controller -c k0s.yml
    ```
- Start K0S Server: 
    ```bash
    sudo k0s start
    ```
- Get the KubeConfig admin file 
    ```bash
    sudo k0s kubeconfig admin > kube_admin.yml
    ```

### Install Worker node
- Generate a worker join token: 
    ```bash
    k0s token create --role=worker > tokenFile
    ```
    - Add expiry to token: 
    ```bash
    k0s token create --role=worker --expiry=100h > tokenFile
    ```
- Join the worker to control node: 
    ```bash
    sudo k0s install worker --token-file
    ```
- Start the worker:
    ```bash
    sudo k0s start
    ```

### Get the KubeConfig.yml
- 
    ```bash
    sudo k0s kubeconfig admin > kubeconfig.yml
    ```

### Set the KubeConfig for kubectl cli
- Download or copy and save to local pc.
- Export the KUBE_CONFIG env variable.
- ⚠ Exports work only for the session.
- Linux
    ```bash
    export KUBE_CONFIG="$PWD/kubeadmin.yml"
    ```
- Windows Powershell
    ```pwsh
    $env:KUBE_CONFIG="${pwd}/kubeadmin.yml"
    ```

### Setup for local Kubernetes cluster
- Required Terraform and docker installed
- Run below command to download the necessary provider
    ```bash
    terraform init
    ```
- Run below to run containers
    ```bash
    terraform apply
    ```
- Run below to destroy
    ```bash
    terraform destroy
    ```

### the content is extracted from the k0s installation docs. [LINK HERE](https://docs.k0sproject.io/v1.21.2+k0s.1/k0s-multi-node/#install-k0s)

### TODO: Easier version to install K0S. [link](https://docs.k0sproject.io/v1.21.2+k0s.1/k0sctl-install/)