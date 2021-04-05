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

        stage('Check Project') {
            steps {
                script {
                    openshift.withCluster() {
                        openshift.withProject() {
                            echo "Using project: ${openshift.project()} in cluster ${openshift.cluster()}"
                        }
                    }
                }
            }
        }

        stage('Create Image Builder') {
            when {
                expression {
                    openshift.withCluster() {
                        return !openshift.selector("bc", "${appName}").exists()
                    }
                }
            }
            steps {
                script {
                    openshift.withCluster() {
                        openshift.newBuild("--name=${appName}", "--image-stream=redhat-openjdk18-openshift:1.5", "--binary")
                    }
                }

            }
        }

        stage('Build Image') {
            steps {
                script {
                    openshift.withCluster() {
                        openshift.selector("bc", "${appName}").startBuild("--from-file=target/todo-list-jenkins-0.0.1-SNAPSHOT.jar", "--wait")
                    }
                }

            }
        }

        stage('Promote to DEV') {
            steps {
                script {
                    openshift.withCluster() {
                        openshift.tag("${appName}:latest", "${appName}:dev")
                    }
                }

            }
        }

        stage('Create DEV') {
            when {
                expression {
                    openshift.withCluster() {
                        return !openshift.selector("dc", "${appName}-dev").exists()
                    }
                }

            }
            steps {
                script {
                    openshift.withCluster() {
                        openshift.newApp("${appName}:latest", "--name=${appName}-dev").narrow('svc').expose()
                    }
                }

            }
        }

        stage('Approval to Stage') {
            steps {
                timeout(time: 30, unit: 'DAYS') {
                    input message: "Start first rollout ?"
                }
            }
        }

        stage('Promote STAGE') {
            steps {
                script {
                    openshift.withCluster() {
                        openshift.tag("${appName}:dev", "${appName}:stage")
                    }
                }
            }
        }
        stage('Create STAGE') {
            when {
                expression {
                    openshift.withCluster() {
                        return !openshift.selector('dc', '${appName}-stage').exists()
                    }
                }
            }
            steps {
                script {
                    openshift.withCluster() {
                        openshift.newApp("${appName}:stage", "--name=${appName}-stage").narrow('svc').expose()
                    }
                }
            }
        }
    }
    environment {
        appName = 'todolist'
        projectOpenshiftName = 'kalwitalo'
    }
}
