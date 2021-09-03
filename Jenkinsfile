pipeline {
  agent any
    tools {
      maven 'maven 3.6'
      jdk 'java 8'
    }
    stages {      
        stage('Build maven ') {
            steps { 
                    sh 'pwd'      
                    sh 'mvn  clean install package'
            }
        }
        
        stage('Copy Artifact') {
           steps { 
                   sh 'pwd'
		   sh 'cp -r target/*.jar docker'
           }
        }
         
        stage('Build docker image') {
           steps {
               script {         
                 def customImage = docker.build('omeshwarkandari/dockerimage', "./docker")
                 docker.withRegistry('https://hub.docker.com/r/omeshwar/omjyokan', 'mydocker-reg') {
                 customImage.push("${env.BUILD_NUMBER}")
                 }                     
               }
           }
	}
    }
}
