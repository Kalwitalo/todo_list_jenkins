pipeline {
  agent any

  stages {
    stage('Docker node test') {
      agent {
          kubernetes {
            // Set both label and image
            label 'openshift'
            image 'node:7-alpine'
            args '--name docker-node' // list any args
          }
      }
      steps {
          // Steps run in node:7-alpine docker container on docker slave
          sh 'node --version'
      }
    }

  }
}
