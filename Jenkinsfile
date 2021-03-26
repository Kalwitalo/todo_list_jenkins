pipeline {
  agent any
  stages {
    stage('Package') {
      steps {
        echo 'Starting'
        sh 'mvn package'
      }
    }

    stage('Deploy') {
      steps {
        podTemplate(cloud: 'openshift')
      }
    }

  }
}