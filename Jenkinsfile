pipeline {
    agent any
    stages {

        stage('Run maven') {
            steps {
                node(label: 'maven') {
                    sh 'mvn clean install -DskipTests=true'
                }
            }
        }
    }
}
