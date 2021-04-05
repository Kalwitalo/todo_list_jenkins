pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                node(label: 'maven') {
                    checkout scm
                    sh 'mvn clean install -DskipTests=true'
                    archiveArtifacts(artifacts: 'target/*.jar', fingerprint: true)
                }
            }
        }
        stage('Publish') {
            sh 'echo Publishing'
        }
    }
}
