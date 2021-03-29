pipeline {
  agent {
    kubernetes {
      cloud 'openshift'
    }

  }
  stages {
    stage('Run maven') {
      steps {
        podTemplate() {
          node(label: 'maven') {
            sh 'mvn clean install -DskipTests=true'
          }

        }

      }
    }

  }
}