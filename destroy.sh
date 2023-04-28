# Change into the infrastructure folder
cd ./infrastructure/_dev

# Run the terraform 
terraform destroy -auto-approve

# Change into the serverless application folder and deploy latest configuration
cd ./app

# Deploy serverless application
sls remove
