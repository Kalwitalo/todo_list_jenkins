pipeline {
    agent {
        node(label: 'maven') {
            checkout scm
            sh 'mvn clean install -DskipTests=true'
            archiveArtifacts(artifacts: 'target/*.jar', fingerprint: true)
        }
    }
}
