pipeline {
  agent {
    kubernetes {
      cloud 'openshift'


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
