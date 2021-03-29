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
            sh 'mvn clean install -DskipTests=true'
        }
    }

  }
}
