Step 1: Generate Spring Boot Application
Go to start.spring.io:

Project: Maven
Language: Java
Spring Boot: (select the latest stable version)
Project Metadata:
Group: com.example
Artifact: demo
Name: demo
Package Name: com.example.demo
Packaging: Jar
Java: 17
Add Dependencies:
Spring Web
==================================
Explanation
Triggers:

The workflow triggers on any push to the main branch.
Environment Variables:

DOCKER_IMAGE, CONTAINER_REGISTRY, EKS_CLUSTER_NAME, AWS_REGION, and TF_WORKING_DIR are set for reusability.
Build Job:

Checks out the code.
Sets up Docker Buildx.
Logs in to Docker Hub using secrets.
Builds and pushes the Docker image to the container registry.
Test Job:

Runs after the build job.
Checks out the code.
Runs the tests.
Deploy Job:
Runs after the test job.
Checks out the code.
Configures AWS credentials using secrets.
Sets up Terraform.
Initializes and applies the Terraform configuration.
Updates the EKS deployment with the new Docker image.
=====================
Create IAM User and Generate Access Keys
Complete the process and download the credentials.csv file which contains your Access Key ID and Secret Access Key.
3. Configure AWS CLI
You can configure the AWS CLI using the aws configure command
Securely Store AWS Credentials
Use AWS Credentials File
AWS CLI stores your credentials in the ~/.aws/credentials file. Ensure the file has proper permissions set to prevent unauthorized access
Use Environment Variables

Set AWS credentials as environment variables. This is particularly useful for temporary sessions and CI/CD pipelines
Use AWS IAM Roles

For EC2 instances, Lambda functions, or ECS tasks, use IAM roles to manage credentials securely without hardcoding them:

EC2 Instances:
Create an IAM role with the necessary permissions.
Attach the role to your EC2 instance.
Lambda Functions:
Assign the appropriate role when creating or updating the Lambda function.
ECS Tasks:
Define a task role with the required permissions and specify it in the task definition.
Use AWS Secrets Manager

Store your credentials in AWS Secrets Manager for enhanced security and retrieval:

Store the credentials in Secrets Manager.
Use the AWS SDK or CLI to retrieve the credentials securely within your application or script.
5. Validate Configuration
Test your configuration by running an AWS CLI command:

sh
Copy code
aws sts get-caller-identity
