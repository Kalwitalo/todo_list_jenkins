pipeline {
  agent {
    docker {
      image 'maven'
    }

  }
  stages {
    stage('Run maven') {
      steps {
        sh 'mvn --version'
      }
    }

  }
}