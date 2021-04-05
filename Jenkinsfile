pipeline {
    def projectName = "TodoList"
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

        stage('Create Image Builder') {
            when {
                expression {
                    openshift.withCluster() {
                        return !openshift.selector("bc", ${projectName}).exists()
                    }
                }
            }
            steps {
                script {
                    openshift.withCluster() {
                        openshift.newBuild("--name=" + ${projectName}, "--image-stream=redhat-openjdk18-openshift", "--binary")
                    }
                }
            }
        }

        stage('Build Image') {
            steps {
                script {
                    openshift.withCluster() {
                        openshift.selector("bc", ${projectName}).startBuild("--from-file=target/todo-list-jenkins-0.0.1-SNAPSHOT.jar", "--wait")
                    }
                }
            }
        }

        stage('Promote to DEV') {
            steps {
                script {
                    openshift.withCluster() {
                        openshift.tag(${projectName} + ":latest", ${projectName} + ":dev")
                    }
                }
            }
        }

        stage('Create DEV') {
            when {
                expression {
                    openshift.withCluster() {
                        return !openshift.selector('dc', ${projectName} + '-dev').exists()
                    }
                }
            }
            steps {
                script {
                    openshift.withCluster() {
                        openshift.newApp(${projectName}+":latest", "--name="+ ${projectName} + "-dev").narrow('svc').expose()
                    }
                }
            }
        }
    }
}
