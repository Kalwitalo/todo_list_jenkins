node(label: 'maven') {
pipeline {
  agent {
    kubernetes {
      cloud 'openshift'
    }
  }
  stages {
    stage('Run maven') {
      steps {

            sh 'mvn clean install -DskipTests=true'
          }
      }
    }
  }
}
