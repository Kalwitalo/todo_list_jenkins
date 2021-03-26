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
          podTemplate {
              node('nodejs') {
                  stage('Run shell') {
                      sh 'echo hello world'
                  }
              }
          }
      }
    }

  }
}
