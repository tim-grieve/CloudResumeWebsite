# CloudResumeWebsite
## Description
Front end website displaying my resume. Uses AWS S3 and Cloudfront to present and html website over https secured by an AWS Certificate Manager public certificate.

Inspired by Forest Brazeal's Cloud Resume Challenge https://cloudresumechallenge.dev/docs/the-challenge/

## Components
### AWS S3
The website consists of HTML, CSS and javascript code which is hosted in an S3 bucket. The S3 bucket policy restricts access to the Origin Access id of the CloudFront distribution. The javascript code displays a count of visitors to the site by retrieving the count form the cloud resume backend https://github.com/tim-grieve/CloudResumeBackend

### AWS Cloudfront Distribution
The website is deployed via https using a cloudfront distribution with the S3 bucket set as the origin endpoint. the domain name is set to resume.shellflow.com and is secured by an AWS Certificate Manager public certificate. 


