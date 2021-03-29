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
        sh 'mvn clean install -DskipTests=true'
      }
    }

  }
}
