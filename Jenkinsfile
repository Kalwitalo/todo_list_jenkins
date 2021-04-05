pipeline {
  agent any
  stages {
    stage('Allocate Node Maven') {
      steps {
        node(label: 'maven')
      }
    }

    stage('Process') {
      parallel {
        stage('Build Maven') {
          steps {
              checkout scm
          }
        }
        stage('Build Maven') {
          steps {
            sh 'mvn clean install -DskipTests=true'
          }
        }

        stage('Arquivar Artefatos') {
          steps {
            archiveArtifacts(artifacts: 'target/*.jar', fingerprint: true)
          }
        }

      }
    }

  }
}
