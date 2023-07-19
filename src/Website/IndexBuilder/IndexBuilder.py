import json
import os
from jinja2 import Environment, FileSystemLoader

#Store inputs in JSON file
with open ('content.json') as json_file:
    content = json.load(json_file)

#Build HTML file for website
environment = Environment(loader=FileSystemLoader("templates/"))
resume_filename = "../index.html"
#resume_template = environment.get_template("resume.html")
print(os.getcwd())
#context = {
#    "resume_name": content['details']['name'],
#    "email": content['details']['email'],
#    "linkedin": content['details']['linkedinurl'],
#    "github": content['details']['githuburl'],
#    "jobs": content['experience'],
#    "certs": content['certifications'],
#    'projects': content['projects']
#}

#with open(resume_filename, mode="w", encoding="utf-8") as resume:
#    resume.write(resume_template.render(context))




