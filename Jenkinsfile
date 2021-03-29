pipeline {
  agent {
    kubernetes {
        cloud 'openshift'
        label 'test'
    }
  }
  stages {
    stage('Build') {
      steps {
        container('maven') {
            sh 'maven clean install -DskipTests=true'
        }
      }
    }

  }
}
