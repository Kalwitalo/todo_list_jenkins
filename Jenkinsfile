pipeline {
  agent {
    kubernetes {
      cloud 'openshift'
      containerTemplate {
        name 'maven'
      }

    }

  }
  stages {
    stage('Run maven') {
      steps {


        container('maven') {
           sh 'mvn clean install -DskipTests=true'
        }

      }
    }

  }
}
