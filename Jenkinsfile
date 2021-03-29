pipeline {
  agent {
    kubernetes {
      cloud 'openshift'
      containerTemplate {
        name 'maven'
        image 'maven:3.3.9-jdk-8-alpine'
        ttyEnabled true
        command 'cat'
      }

    }

  }
  stages {
    stage('Run maven') {
      steps {


        container('maven') {
           sh 'mvn clean install -DskipTests=true'
        }

      }
    }

  }
}
