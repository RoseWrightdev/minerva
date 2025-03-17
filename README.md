minerva/
├── backend/           # Go backend code
│   ├── main.go
│   ├── Dockerfile
│   └── ...
├── frontend/          # React dashboard code
│   ├── app/
│   ├── package.json
│   └── ...
├── manifests/         # Kubernetes manifests
│   ├── backend-deployment.yaml
│   ├── backend-service.yaml
│   ├── frontend-deployment.yaml
│   ├── frontend-service.yaml
│   ├── gateway-api.yaml
│   └── ...
├── scripts/           # Scripts for cluster setup, deployment, etc.
│   ├── create-cluster.sh
│   ├── deploy-app.sh
│   └── ...
├── README.md          # Project documentation
├── .gitignore
└── ...
