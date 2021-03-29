pipeline {
  agent any
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
