pipeline {
  agent {
    kubernetes {
        cloud 'openshift'
        label 'maven'
    }
  }
  stages {
    stage('Build') {
      steps {
        container('maven') {
            sh 'mvn clean install -DskipTests=true'
        }
      }
    }

  }
}
