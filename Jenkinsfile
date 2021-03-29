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
          node(label: 'maven') {
            container('maven') {
                       sh 'mvn clean install -DskipTests=true'
                    }
          }

        }
      }
    }

  }
}
