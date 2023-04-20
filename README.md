# CloudResumeWebsite
## Description
Front end website displaying my resume. Uses AWS S3 and Cloudfront to present and html website over https secured by an AWS Certificate Manager public certificate.

Inspired by Forest Brazeal's Cloud Resume Challenge https://cloudresumechallenge.dev/docs/the-challenge/

## Components
### AWS S3
The website consists of HTML, CSS and javascript code which is hosted in an S3 bucket. The S3 bucket policy restricts access to the Origin Access id of the CloudFront distribution. The javascript code displays a count of visitors to the site by retrieving the count form the cloud resume backend https://github.com/tim-grieve/CloudResumeBackend

### AWS Cloudfront Distribution
The website is deployed via https using a cloudfront distribution with the S3 bucket set as the origin endpoint. the domain name is set to resume.shellflow.com and is secured by an AWS Certificate Manager public certificate. 

## Deployment
### Terraform
All of the components are deployed using Terraform  

### Github Actions
All changes are intially deployed to the test branch which triggers a github actions workflow to run intiall tests and initiating a pull request to the main repo on success. The pull request is automatically merged into the main branch and triggers a github actions workflow to deploy all chnages to prod and perform a Cypress end to end test to ensure the website is active.

## Areas for improvement
### Folder structure 
There are some files and folders that would benifit from some reorganisation to make the file and folder layout more logical.
### Additonal cypress tests
Right now the cypress test just confirms the site is reachable. The test could be imporved by adding additonal checks such as testing https connectivity and probing for security vulerabilities.
### HTML and CSS
The website is very basic and could be improved with a little bit of attention to the content and formatting.
### Comments in code
All of the code would benifit from extra commenting as it is a little light at present.


