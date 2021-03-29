pipeline {
  agent {
    kubernetes {
      cloud 'openshift'
      args '-v /root/.m2:/root/.m2'
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
