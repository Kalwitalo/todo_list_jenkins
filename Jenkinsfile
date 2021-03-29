pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh 'maven clean install -DskipTests=true'
      }
    }

  }
}