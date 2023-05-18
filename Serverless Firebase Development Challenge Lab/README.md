## BServerless Firebase Development: Challenge Lab ##
**Task 1. Create a Firestore database** <br/>
```
gcloud config set project $(gcloud projects list --format='value(PROJECT_ID)' --filter='qwiklabs-gcp')
git clone https://github.com/rosera/pet-theory.git
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
Go to Firestore > Select Naive Mode > Location: nam5 > Create Database
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

```
**Task 2. Populate the Database** <br/>
```
cd pet-theory/lab06/firebase-import-csv/solution
npm install
node index.js netflix_titles_original.csv
```
**Task 3. Create a REST API** <br/>
```
cd ~/pet-theory/lab06/firebase-rest-api/solution-01
npm install
gcloud builds submit --tag gcr.io/$GOOGLE_CLOUD_PROJECT/rest-api:0.1
gcloud beta run deploy [netflix-dataset-service] --image gcr.io/$GOOGLE_CLOUD_PROJECT/rest-api:0.1 --allow-unauthenticated
# Choose 1 and us-central1
```
**Task 4. Firestore API access** <br/>
```
cd ~/pet-theory/lab06/firebase-rest-api/solution-02
npm install
gcloud builds submit --tag gcr.io/$GOOGLE_CLOUD_PROJECT/rest-api:0.2
gcloud beta run deploy [netflix-dataset-service] --image gcr.io/$GOOGLE_CLOUD_PROJECT/rest-api:0.2 --allow-unauthenticated
# go to cloud run and click netflix-dataset-service then copy the url
SERVICE_URL=<copy url from your netflix-dataset-service>
curl -X GET $SERVICE_URL/2019
```
**Task 5. Deploy the Staging Frontend** <br/>
```
cd ~/pet-theory/lab06/firebase-frontend/public
nano app.js # comment line 3 and uncomment line 4, insert your netflix-dataset-service url
npm install
cd ~/pet-theory/lab06/firebase-frontend
gcloud builds submit --tag gcr.io/$GOOGLE_CLOUD_PROJECT/frontend-staging:0.1
gcloud beta run deploy [frontend-staging-service] --image gcr.io/$GOOGLE_CLOUD_PROJECT/frontend-staging:0.1
# Choose 1 and us-central1
```
**Task 6. Deploy the Production Frontend** <br/>
```
gcloud builds submit --tag gcr.io/$GOOGLE_CLOUD_PROJECT/frontend-production:0.1
gcloud beta run deploy [frontend-production-service] --image gcr.io/$GOOGLE_CLOUD_PROJECT/frontend-production:0.1
# Choose 1 and us-central1
```
