pipeline {
  agent any

  stages {
    stage('Docker node test') {
      agent {
          kubernetes {
            // Set both label and image
            label 'openshift'
            cloud 'openshift'
          }
      }
      steps {
          // Steps run in node:7-alpine docker container on docker slave
          sh 'node --version'
      }
    }

  }
}
