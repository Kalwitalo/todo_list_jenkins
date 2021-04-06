pipeline {
    agent any
    stages {
            stage('Non-Sequential Stage') {
                steps {
                    echo "On Non-Sequential Stage"
                }
            }
            stage('Sequential') {
                agent {
                    label 'for-sequential'
                }
                environment {
                    FOR_SEQUENTIAL = "some-value"
                }
                stages {
                    stage('In Sequential 1') {
                        steps {
                            echo "In Sequential 1"
                        }
                    }
                    stage('In Sequential 2') {
                        steps {
                            echo "In Sequential 2"
                        }
                    }
                    stage('Parallel In Sequential') {
                        parallel {
                            stage('In Parallel 1') {
                                steps {
                                    echo "In Parallel 1"
                                }
                            }
                            stage('In Parallel 2') {
                                steps {
                                    echo "In Parallel 2"
                                }
                            }
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
