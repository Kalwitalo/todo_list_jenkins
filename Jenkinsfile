pipeline {
  agent any
  node("openshift") {
      stages {
        stage('init') {
          steps {
            sh 'echo hello world'
          }
        }
      }
  }
}
