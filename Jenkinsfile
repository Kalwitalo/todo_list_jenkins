pipeline {
  agent {
    kubernetes {
      cloud 'openshift'
      node 'maven'
    }
  }

  node(label: 'maven') {
  }
  stages {
    stage('Before All') {
        steps {
            sh 'ls -lu'
            sh 'mvn clean install -DskipTests=true'
        }
    }

  }
}
