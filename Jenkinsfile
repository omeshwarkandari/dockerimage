pipeline {
  agent any
    tools {
      maven 'maven 3.6'
      jdk 'java 8'
    }         
  stages {       
    stage ('clone the repo') {
      steps {
          git 'https://github.com/omeshwarkandari/dockerimage.git'
      }
    }
    stage ('build image') {
      steps { 
          app = docker.build("omeshwarkandari/dockerimage")
      }
    }
  }
}
