# Change into the infrastructure folder
cd ./infrastructure/_dev

echo "Formatting terraform code..."
# Format terraform module code
terraform fmt -recursive

echo "Running terraform plan phase"
# Run the terraform plan for reviewing 
terraform plan

echo "Applying terraform resources to deploy"
# Run the terraform 
terraform apply -auto-approve

echo "Storing outputs of deployed infrastructure into ./app/config.json file"
# Spit out terraform outputs from insfrastructure resources, format and store in config.json file for the serverless framework
terraform output -json | jq 'with_entries(.value |= .value)' > ./app/config.json

# Change into the serverless application folder and deploy latest configuration
cd ./app

echo "Deploying serverless application..."
# Deploy serverless application
sls deploy

# Change into the infrastructure folder
cd ./infrastructure

# Get cost breakdown
infracost breakdown --path .
