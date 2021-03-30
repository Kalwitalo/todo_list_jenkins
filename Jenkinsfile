pipeline {
  agent any
  tools {
      maven 'maven'
      jdk 'jdk8'
  }
  stages {

    stage('Run maven') {
      steps {
        echo "PATH = ${PATH}"
        echo "M2_HOME = ${M2_HOME}"
        sh 'mvn clean install -DskipTests=true'
      }
    }
  }
  post {
    always {
        archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
    }
  }
}
