pipeline {
  agent {
    docker {
      image 'maven'
    }

  }
  stages {
    stage('Run maven') {
      steps {
        sh 'mvn clean install -DskipTests=true'
      }
    }

  }
  tools {
    maven 'maven'
    jdk 'jdk8'
  }
  post {
    always {
      archiveArtifacts(artifacts: 'target/*.jar', fingerprint: true)
    }

  }
}