import json
import boto3
from jinja2 import Environment, FileSystemLoader

#Store inputs in JSON file
with open ('content.json') as json_file:
    content = json.load(json_file)

#Build HTML file for website
environment = Environment(loader=FileSystemLoader("Templates/"))
resume_filename = "/tmp/index.html"
resume_template = environment.get_template("resume.html")

context = {
    "resume_name": content['details']['name'],
    "email": content['details']['email'],
    "linkedin": content['details']['linkedinurl'],
    "github": content['details']['githuburl'],
    "jobs": content['experience'],
    "certs": content['certifications'],
    'projects': content['projects']
}

with open(resume_filename, mode="w", encoding="utf-8") as resume:
    resume.write(resume_template.render(context))

#Upload File to S3
client = boto3.client("s3")
client.upload_file("/tmp/index.html", "s3://tgrieve-resume-bucket", "/index.html")




