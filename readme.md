Set-up Jenkins Server
Add plug-in "Dokcer Pipeline"
Additonal Configuration:
Install Docker:
$ yum install docker
$ service docker start
$ chkconfig docker on

( Create a sample Dockerfile and trest the build "docker build -t imagename ." both as user "root" & "jenkins", it might fail jenkins due to permision issue ).

Provide permision to jenkins user to run docker build:
Add a group docker: $ groupadd docker
Add docker into this group: $ usermod -aG docker
$ chown -R jenkins:jenkins Dockerfile
$ chmod 666 /var/run/docker.sock
reboot the server

Authenticate Jenkins to push image to Dockerhub:
This is achieved by adding Dockerhub User credentials in the jenkins Global Credentials menu.
1. Create a token as password in the Dockerhub Registry:
Login to Docker-hub --- right click on Reg. name "omeshwar" -- Account Settings -- Security -- Create a token and copy it.
2. Go to Jenkins Credential -- add Credential -- (Kind: username & passwd, username: <Dokcerhub reg name> e.g. "omeshwar", password: <token value>, ID: Any name e.g "dockerhub"
3. Use this ID in the jenkinsfile.
  
jenkinsfile:
stage('Copy Artifact'): 
"pwd": means the present working directory where artifact is created by the jenkins job e.g. a pipeline job named as "jenkins-docker-integration"
   which means /var/lib/jenkins/workspace/jenkins-docker-integration/target where the artifacts "spring-petclinic-2.2.0.BUILD-SNAPSHOT.jar docker" is stored.
"cp -r target/*.jar docker": The artifact a jar file inside the pwd is copied to the "dockerfile" inside the directory "docker" we have created in the root of the github repo,
    which means the action is like " copy *.jar filr to the /docker/Dockerfile " and this is accomplished by the configuration of the "Dockerfile"
 
Dockerfile:
    
 
    
         
        stage('Build docker image') {
           steps {
               script {         
                 def customImage = docker.build('omeshwar/petclinic', "./docker")
                 docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                 customImage.push("${env.BUILD_NUMBER}")
                 }                  

