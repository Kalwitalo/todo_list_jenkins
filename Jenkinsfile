pipeline {
    agent any
    stages {

        stage('Check Project') {
            steps {
                script {

                        sh "docker ps"

                }
            }
        }
    }

    environment {
        appName = 'todolist'
        projectOpenshiftName = 'todolist-test'
        office365WebhookUrl = 'https://techleadit.webhook.office.com/webhookb2/e9431669-990d-4cd1-95b5-095dd35512f3@c4ecbfec-df4a-4171-9e88-a56dff7d9839/JenkinsCI/f0725e283b9f4df19a45a1e42ef9f79a/d1568b67-4de9-4f2e-8fa4-a8ee1a59ef31'
    }
}
