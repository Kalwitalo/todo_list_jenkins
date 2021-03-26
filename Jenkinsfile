pipeline {
  agent any

  stages {
    stage('Docker node test') {
      agent {
          kubernetes {
            // Set both label and image
            cloud 'openshift'
            image 'nodejs'
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
