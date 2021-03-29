pipeline {
  agent {
    kubernetes {
      cloud 'openshift'
    }
  }
  stages {
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
