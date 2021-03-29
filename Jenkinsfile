pipeline {
  agent {
    kubernetes {
      cloud 'openshift'
    }
  }
  stages {
  node(label: 'maven') {
    stage('Run maven') {
      steps {

            sh 'mvn clean install -DskipTests=true'
          }
      }
    }
  }
}
