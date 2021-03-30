pipeline {
  agent any
  tools {
      maven 'Maven 3.3.9'
      jdk 'jdk8'
  }
  stages {

    stage('Run maven') {
      steps {
        sh 'mvn clean install -DskipTests=true'
      }
    }
  }
}
