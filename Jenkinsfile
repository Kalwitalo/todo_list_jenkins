pipeline {
  agent any
  stages {
    stage('Run maven') {
      steps {
        node(label: 'maven') {
          unstash '.'
          sh 'mvn clean install -DskipTests=true'
        }

      }
    }

  }
}