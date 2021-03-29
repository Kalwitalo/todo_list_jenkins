pipeline {
  agent {
    kubernetes {
      cloud 'openshift'
    }

  }
  stages {
    stage('Run maven') {
      steps {
        podTemplate(cloud: 'openshift') {
            node('maven') {
                stage('Run shell') {
                    sh 'mvn -version'
                }
            }
        }
      }
    }
  }
}
