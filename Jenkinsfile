pipeline {
    agent {
        docker {
            agent {
                label 'docker-slave'
            }
        }
    }
    stages {
        stage('Build') {
            steps {
                sh 'docker ps'
            }
        }
    }
}
