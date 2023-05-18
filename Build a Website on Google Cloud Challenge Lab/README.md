## Build a Website on Google Cloud: Challenge Lab ##
**Task 1. Download the monolith code and build your container** <br/>
```
git clone https://github.com/googlecodelabs/monolith-to-microservices.git
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
cd ~/monolith-to-microservices
./setup.sh
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
nvm install --lts
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
cd ~/monolith-to-microservices/monolith
gcloud builds submit --tag gcr.io/${GOOGLE_CLOUD_PROJECT}/${MONOLITH_IDENTIFIER}:1.0.0 .
```
**Task 2. Create a kubernetes cluster and deploy the application** <br/>
```
gcloud config set compute/zone us-central1-a
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
gcloud container clusters create $CLUSTER_NAME --num-nodes 3
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
gcloud container clusters get-credentials $CLUSTER_NAME
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
kubectl create deployment $MONOLITH_IDENTIFIER --image=gcr.io/${GOOGLE_CLOUD_PROJECT}/${MONOLITH_IDENTIFIER}:1.0.0
kubectl expose deployment $MONOLITH_IDENTIFIER --type=LoadBalancer --port 80 --target-port 8080
```
**Task 3. Create new microservices** <br/>
```
cd ~/monolith-to-microservices/microservices/src/orders
gcloud builds submit --tag gcr.io/${GOOGLE_CLOUD_PROJECT}/${ORDERS_IDENTIFIER}:1.0.0 .
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
cd ~/monolith-to-microservices/microservices/src/products
gcloud builds submit --tag gcr.io/${GOOGLE_CLOUD_PROJECT}/${PRODUCTS_IDENTIFIER}:1.0.0 .
```
**Task 4. Deploy the new microservices** <br/>
```
kubectl create deployment $ORDERS_IDENTIFIER --image=gcr.io/${GOOGLE_CLOUD_PROJECT}/${ORDERS_IDENTIFIER}:1.0.0
kubectl expose deployment $ORDERS_IDENTIFIER --type=LoadBalancer --port 80 --target-port 8081
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
kubectl get svc -w
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
kubectl create deployment $PRODUCTS_IDENTIFIER --image=gcr.io/${GOOGLE_CLOUD_PROJECT}/${PRODUCTS_IDENTIFIER}:1.0.0
kubectl expose deployment $PRODUCTS_IDENTIFIER --type=LoadBalancer --port 80 --target-port 8082
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
kubectl get svc -w
```
**Task 5. Configure and deploy the Frontend microservice** <br/>
```
export ORDERS_SERVICE_IP=$(kubectl get services -o jsonpath="{.items[1].status.loadBalancer.ingress[0].ip}")
export PRODUCTS_SERVICE_IP=$(kubectl get services -o jsonpath="{.items[2].status.loadBalancer.ingress[0].ip}")
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
cd ~/monolith-to-microservices/react-app
sed -i "s/localhost:8081/$ORDERS_SERVICE_IP/g" .env
sed -i "s/localhost:8082/$PRODUCTS_SERVICE_IP/g" .env
npm run build
```
**Task 6. Create a containerized version of the Frontend microservice** <br/>
```
cd ~/monolith-to-microservices/microservices/src/frontend
gcloud builds submit --tag gcr.io/${GOOGLE_CLOUD_PROJECT}/${FRONTEND_IDENTIFIER}:1.0.0 .
```
**Task 7. Deploy the Frontend microservice** <br/>
```
kubectl create deployment $FRONTEND_IDENTIFIER --image=gcr.io/${GOOGLE_CLOUD_PROJECT}/${FRONTEND_IDENTIFIER}:1.0.0
kubectl expose deployment $FRONTEND_IDENTIFIER --type=LoadBalancer --port 80 --target-port 8080

kubectl get svc -w
```
