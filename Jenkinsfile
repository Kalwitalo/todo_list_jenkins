pipeline {
  agent {
    kubernetes {
        cloud 'openshift'
        containers: [
            containerTemplate(image: 'maven:3.3.9-jdk-8-alpine', name: 'maven', command: 'cat', ttyEnabled: true)
        ],
    }
  }
  stages {
    stage('Run maven') {
        steps {
            container('maven') {
                sh 'mvn -version'
            }
        }
    }
  }
}
