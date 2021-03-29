pipeline {
  agent {
    kubernetes {
      cloud 'openshift'
    }
  }

          node(label: 'maven') {
  stages {
    stage('Run maven') {
      steps {

            git 'https://github.com/jenkinsci/kubernetes-plugin.git'
            sh 'mvn clean install -DskipTests=true'
          }
      }
    }
  }
}
