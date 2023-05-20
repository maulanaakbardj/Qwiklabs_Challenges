# Build and Deploy a Docker Image to a Kubernetes Cluster

gsutil cp gs://sureskills-ql/challenge-labs/ch04-kubernetes-app-deployment/echo-web.tar.gz .

tar -xvf echo-web.tar.gz

gcloud builds submit --tag gcr.io/<GCP_Project_ID>/echo-app:v1 .

gcloud container clusters create echo-cluster --num-nodes 2 --zone us-central1-a --machine-type n1-standard-2

kubectl create deployment echo-web --image=gcr.io/qwiklabs-resources/echo-app:v1

kubectl expose deployment echo-web --type=LoadBalancer --port=80 --target-port=8000

kubectl get svc
