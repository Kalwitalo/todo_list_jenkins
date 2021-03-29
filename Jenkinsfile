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
        container('jnlp') {
            sh 'mvn clean install -DskipTests=true'
        }
      }
    }

  }
}
