pipeline {
  agent {
    kubernetes {
      cloud 'openshift'
    }

  }
  stages {
    stage('Run maven') {
      steps {
        podTemplate(cloud: 'openshift') {
          sh 'echo -version'
        }

      }
    }

  }
}