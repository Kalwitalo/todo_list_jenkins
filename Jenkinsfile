pipeline {
  agent {
    kubernetes {
      cloud 'openshift'
    }

  }
  stages {
    podTemplate(cloud: 'openshift') {
        stage('Run maven') {
            steps {
                node('maven') {
                    sh 'mvn clean install -DskipTests=true'
                }
            }
        }
    }
  }
}
