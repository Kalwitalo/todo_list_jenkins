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

        stage('Delivery for Dev') {

            steps('Create Image Builder') {
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
            steps('Build Image') {
                script {
                    openshift.withCluster() {
                        openshift.selector("bc", "${appName}").startBuild("--from-file=target/todo-list-jenkins-0.0.1-SNAPSHOT.jar", "--wait")
                    }
                }

            }
            steps('Promote to DEV') {
                script {
                    openshift.withCluster() {
                        openshift.tag("${appName}:latest", "${appName}:dev")
                    }
                }

            }
            steps('Create DEV') {
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
        }



        stage('Send message to Channel') {
            steps {
                office365ConnectorSend webhookUrl: "${office365WebhookUrl}",
                    message: "A Aplicação foi implantada em ambiente de desenvolvimento"+
                             "<br>Duração total do pipeline: ${currentBuild.durationString}",
                    status: "Sucesso",
                    color: "#99C712"
            }
        }

        stage('Approval to Stage') {
            steps {
                timeout(time: 30, unit: 'DAYS') {
                    input message: "Deploy this build to QA?"
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

    post {
        failure {
            script {
                office365ConnectorSend "${office365WebhookUrl}",
                    message: "A Aplicação ${JOB_NAME} - ${BUILD_DISPLAY_NAME} sofreu uma falha durante o processo de build."+
                             "<br>Duração total do pipeline: ${currentBuild.durationString}",
                    status: "Falhou",
                    color: "#DC6650"
            }
        }
    }

    environment {
        appName = 'todolist'
        projectOpenshiftName = 'kalwitalo'
        office365WebhookUrl = 'https://techleadit.webhook.office.com/webhookb2/e9431669-990d-4cd1-95b5-095dd35512f3@c4ecbfec-df4a-4171-9e88-a56dff7d9839/JenkinsCI/f0725e283b9f4df19a45a1e42ef9f79a/d1568b67-4de9-4f2e-8fa4-a8ee1a59ef31'
    }
}
