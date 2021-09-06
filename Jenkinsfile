pipeline {
  agent any
    tools {
      maven 'maven 3'
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
        sh 'docker build -t hello_world .'
      }
    }
  }
}
