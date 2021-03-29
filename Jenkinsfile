pipeline {
  agent {
    kubernetes {
      cloud 'openshift'
    }
  }
  stages {
    stage('Run maven') {
      steps {
          git 'https://github.com/jenkinsci/kubernetes-plugin.git'
          node(label: 'maven') {
            sh 'mvn clean install -DskipTests=true'
          }
      }
    }
  }
}
