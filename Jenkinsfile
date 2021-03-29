pipeline {
  agent {
    kubernetes {
      cloud 'openshift'
    }
  }
  stages {
    stage('Before All') {
        steps {
            sh 'ls -lu'
        }
    }
    stage('Run maven') {
      steps {
          node(label: 'maven') {

            git 'https://github.com/jenkinsci/kubernetes-plugin.git'
            sh 'mvn clean install -DskipTests=true'
          }
      }
    }
  }
}
