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


        stage('Send message to Channel') {
            steps {
                office365ConnectorSend webhookUrl: "${office365WebhookUrl}",
                    message: "A Aplicação ${JOB_NAME} - ${BUILD_DISPLAY_NAME} foi [implantada](https://uat.green.biz) em ambiente de desenvolvimento"+
                             "<br>Duração total do pipeline: ${currentBuild.durationString}",
                    status: "[![Build: Sucesso](https://img.shields.io/badge/Build-Sucesso-green)]",
                    color: "#99C712"
            }
        }

        stage('Approval to Stage') {
            steps {
                timeout(time: 30, unit: 'DAYS') {
                    input message: "Would you like to approval this for stage?"
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
                    status: "[![Build: Falhou](https://img.shields.io/badge/Build-Falhou-red)]",
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
