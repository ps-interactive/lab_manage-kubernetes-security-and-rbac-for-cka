# Create users
useradd -m user1
useradd -m user2

# Do not set any password for the users
passwd -l user1
passwd -l user2

# Create .kube folders
mkdir -p /home/user1/.kube
mkdir -p /home/user2/.kube

# Generate private key for users
openssl genrsa -out /home/user1/.kube/user1.key 2048
openssl genrsa -out /home/user2/.kube/user2.key 2048

# Create CSR for users
openssl req -new -key /home/user1/.kube/user1.key -out /home/user1/.kube/user1.csr -subj "/CN=user1/O=group1"
openssl req -new -key /home/user2/.kube/user2.key -out /home/user2/.kube/user2.csr -subj "/CN=user2/O=group2"

# Sign the CSR with Minikube's CA
openssl x509 -req -in /home/user1/.kube/user1.csr -CA /home/pslearner/.minikube/ca.crt -CAkey /home/pslearner/.minikube/ca.key -CAcreateserial -out /home/user1/.kube/user1.crt -days 365
openssl x509 -req -in /home/user2/.kube/user2.csr -CA /home/pslearner/.minikube/ca.crt -CAkey /home/pslearner/.minikube/ca.key -CAcreateserial -out /home/user2/.kube/user2.crt -days 365

# Copy minikube CA to user dirs
cp /home/pslearner/.minikube/ca.crt /home/user1/.kube/ca.crt
cp /home/pslearner/.minikube/ca.crt /home/user2/.kube/ca.crt

# Move kubeconfig files to users dirs
mv /home/pslearner/challenges/02/kubeconfig-user1.yaml /home/user1/.kube/config
mv /home/pslearner/challenges/02/kubeconfig-user2.yaml /home/user2/.kube/config

# Provide perms to users
chown user1:user1 /home/user1
chown user2:user2 /home/user2
