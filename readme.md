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
FROM openjdk:11.0.5-jdk  (run a java image being a java program which also helps in removing a layer of "Install Java" in the image."
ADD *.jar app.jar  (ADD command helps to add copied *.jar artifacts on th runtime in the docker dir which is otherwise empty)
ENTRYPOINT java -jar app.jar  (Entrypoint is executing the program java for the created application app.jar when container will spinoff from our image)
    

Docker Image Build and Push: It has two parts first build dockerimage & then push the image to the dockerhub.

Build the Image: 
  <docker.build('<docker-hub reg name/ image name>', "./<Dokcerfile location in the jenkinsfile>"> is a jenkins declarative pipeline syntax for the docker build command
    "docker build -t image-name ." 
  "def customimage": A custom image that we want to build using a successful buil number.
  "docker-hub reg name/ image name": we are using docker-hub registry as "omeshwar" my github registry and image name as "petclinic" just a relevent name to the application. 
  "./<Dokcerfile location in the jenkinsfile>": The relevant path hosting the Dockerfile e.g. docker directory (./docker/Dokcerfile) and it should be alwyas in the root "." direcrory of Github repo where SRC is present.
Push to the Dokerhub registry: We are using pipeline syntax 
  docker.withRegistry('https://registry.hub.docker.com', 'ID of the Credential in the jenkis') {
                 customImage.push("${env.BUILD_NUMBER}")
                 }                  
env.BUILD_NUMBER: This syntax helps to push the successful image with the build number as tag.
