pipeline {
  agent {
    kubernetes {
      cloud 'openshift'
    }

  }
  stages {
    stage('Run maven') {
        podTemplate(cloud: 'openshift') {
            steps {
                node('maven') {
                    sh 'mvn clean install -DskipTests=true'
                }
            }
        }
    }
  }
}
