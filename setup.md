### Start the Server 

```sh
APIURL=http://localhost:8080/api ./run-api-tests.sh

go run hello.go 
```


### Containerize the Application 
MultiStage builds is a recommended way to build production containers

`docker build -t go-backend .`

`git tag -a v0.0.1 -m "attempt two"`

`git push origin v0.0.1`



**Deploy Terraform with github Actions** 
If you want to make a Terraform output readily available for use within your GitHub Actions workflow, you'll typically need to follow this sequence:

1. Deploy Terraform with GitHub Actions:  Create a GitHub Actions workflow that executes your Terraform code (terraform init, terraform plan, terraform apply), provisioning the infrastructure and generating the desired outputs.


2. Capture Terraform Output:  Within your GitHub Action, you'll need to capture the specific output value you need. There are a few ways to do this( The specific output in this case is th ECR url)

### STEP 1
**Create Terraform backend**
1. 
- The S3 Backend will require an S3 Bucket, and a DynamoDB Table (to enable State Locking). It will also require a KMS key to encrypt the bucket.

- We will implement state Locking for a situation where simultaneous runs may occur.Storing the state remotely brings a pitfall, especially when working in scenarios where several tasks, jobs, and team members have access to it. Under these circumstances, the risk of multiple concurrent attempts to make changes to the state is high. Here comes to help the lock, a feature that prevents opening the state file while already in use.

- when you use a Backend, you must make sure that the Terraform process also has permissions to write and read from your Backend infrastructure. It’s crucial restricting the access to the bucket; so create an unprivileged IAM user. The user should have `AmazonS3FullAccess` and `AmazonDynamoDBFullAccess`

- We will use terraform to build the remote state component(s3 bucket and Dynamodb table) in a seperate folder `remote-state` and this will have its own **local** state file.

2. After creating the backend, initialise terraform with the backend to confirm that everything works correctly


### STEP 2 
**Deploy Terraform with Github Action**

**Goals** 
[Reference](https://chloemcateer.medium.com/deploying-terraform-using-github-actions-20937d68160f)
1. The terraform action should only run when there has been changes to a file within the terraform directory

2. View a plan of the terraform changes, when any infra changes are pushed up in a commit to a PR. This will allow any reviewers to review the changes and plan as well.

- There are some caveats to using Github Actions to run your Terraform commands instead of your local terminal. 

a. Actions execute on a hosted runner machine, so you'll need to provide credentials for any cloud service it needs to interact with.
b. The runner machines are ephemeral so you need to use a remote backend for the storage of your state data.





**Build and Push the docker image to ECR**
