pipeline {
    agent any
    stages {
        stage('Run maven') {
            steps {
                node(label: 'maven') {
                    checkout scm
                    sh 'mvn clean install -DskipTests=true'
                }

            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            archiveArtifacts(artifacts: 'target/*.jar', fingerprint: true)
        }
    }
}
