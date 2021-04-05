pipeline {
  agent any
  stages {
    stage('Run maven') {
      steps {
        node(label: 'maven') {
            checkout scm
            sh 'mvn clean install -DskipTests=true'
        }

      }
    }

  }
}
