pipeline {
  agent {
    kubernetes {
        cloud 'openshift'
    }
  }
  stages {
    stage('Run maven') {
        steps {
            sh 'echo -version'
        }
    }
  }
}
