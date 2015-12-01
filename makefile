## aws lambda function experiment
##

# prerequisites
#
#   install maven, e.g.
#     sudo apt-get install mvn  (linux)
#     brew install maven 	(osx)
#
#   see pom.xml for details and dependencies
#

# use maven to build the lambda function package for deployment to AWS
build:
	mvn package

# pre-requisites
#
#   use the IAM console to install lambda_basic.iam.json
#   or create a new IAM lambda role using the existing AWSLambdaRole def...
#     aws -> roles ->
#       create new role -> name: lambda_basic ->
#         lambda -> AWSLambdaRole
#
#   set ROLE_ARN environment variable (using the ID returned above)
#     e.g. ROLE_ARN=arn:aws:iam::{id}:role/lambda_basic
#
#   make sure that you have an ~/.aws/credentials, or set prereq env variables
#     e.g. AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY 
#
RUNTIME=java8
TIMEOUT=15
MEMORY=512
#HANDLER=net.ultrametrics.awslambda.LambdaSumFunction::myHandler
HANDLER=net.ultrametrics.awslambda.LambdaSquareFunction::myHandler
#JAR_PATH=target/awslambda-sum-1.0-SNAPSHOT.jar
JAR_PATH=target/awslambda-square-1.0-SNAPSHOT.jar
#LAMBDA_FUNC=awslambda-sum
LAMBDA_FUNC=awslambda-square
AWS_REGION=us-west-2

# use the AWS cli to create/install the lambda function
#
create:
	aws lambda create-function --region $(AWS_REGION) --function-name $(LAMBDA_FUNC) --zip-file fileb://$(JAR_PATH) --role $(ROLE_ARN) --handler $(HANDLER) --runtime $(RUNTIME) --timeout $(TIMEOUT) --memory-size $(MEMORY)

# use the AWS cli to update the lambda function
#
update:
	aws lambda update-function-code --region $(AWS_REGION) --function-name $(LAMBDA_FUNC) --zip-file fileb://$(JAR_PATH)


# invoke the lambda function
#
INPUT=2
RESPONSE_DEST=/tmp/response
invoke:
	aws lambda invoke --region $(AWS_REGION) --function-name $(LAMBDA_FUNC) --payload $(INPUT) --invocation-type RequestResponse $(RESPONSE_DEST)

