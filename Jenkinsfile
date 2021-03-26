pipeline {
  agent any
  stages {
    stage('Package') {
      steps {
        echo 'Starting'
        sh 'mvn clean package'
      }
    }

    stage('Deploy') {
      steps {
        podTemplate(cloud: 'openshift')
      }
    }

  }
}