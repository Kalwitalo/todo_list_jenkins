pipeline {
    agent {
        node {
            label 'maven'
        }
    }
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean install -DskipTests=true'
                archiveArtifacts(artifacts: 'target/*.jar', fingerprint: true)
            }
        }

        stage('preamble') {
            steps {
                script {
                    openshift.withCluster() {
                        openshift.withProject() {
                            echo "Using project: ${openshift.project()}"
                        }
                    }
                }
            }
        }

    }
}
