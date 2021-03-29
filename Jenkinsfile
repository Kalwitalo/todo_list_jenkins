pipeline {
  agent {
    kubernetes {
        cloud 'openshift'
        label 'test'
    }
  }
  stages {
    stage('Build') {
        container('maven') {
            sh 'mvn clean install -DskipTests=true'
        }
    }
  }
}
