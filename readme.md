CICD Declarative Pipeline by Jenkins to create a docker image from the artifact and push it to the Docker-hub registry.
Required Components:

1. Jenkins Server:
- Create an Amazon EC2 t3.small to avoid low memory issue on docker image creation
- Build Jenkins server: Manual build or using the Ansible Playbook "jenkins_setup.yml"
- Configure Java & Maven Home
- Add plug-in Docker, Dokcer Pipeline 

2. Install Docker: Refer to the document "Docker Installation and access"

3. Create a declarative pipeline inside the "jenkinsfile" and keep it in the root of the SCM Repository. 

4. Create a directory "Docker" and create a Dokcefile inside the directory.
