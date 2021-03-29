pipeline {
  agent {
    kubernetes {
        cloud 'openshift'
        label 'test'
        yamlFile 'jenkins/BuildPod.yaml'
    }
  }
  stages {
    stage('Build') {
      steps {
        container('maven') {
            sh 'mvn clean install -DskipTests=true'
        }
      }
    }

  }
}
