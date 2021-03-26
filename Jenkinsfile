pipeline {
  agent {
      label 'openshift'
  }

  stages {
    stage('Docker node test') {
      agent {
          openshift {
            // Set both label and image
            label 'docker'
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
