pipeline {
    agent {
        kubernetes {
            cloud 'openshift'
        }
    }
    stages {
        stage('Run maven') {
            steps {
                podTemplate(agent: openshift) {
                    node(label: 'maven') {
                        git 'https://github.com/jenkinsci/kubernetes-plugin.git'
                        sh 'mvn clean install -DskipTests=true'
                    }
                }
            }
        }
    }
}
