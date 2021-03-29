pipeline {
  agent {
    kubernetes {
      cloud 'openshift'
    }
  }
  stages {
    stage('Run maven') {
      steps {
          node(label: 'maven') {
            sh 'mvn clean install -DskipTests=true'
          }

      }
    }
  }
}
