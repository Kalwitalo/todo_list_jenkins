pipeline {
    agent {
        node {
            label 'maven'
        }

    }
    stages {

        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests=true'
                archiveArtifacts(artifacts: 'target/*.jar', fingerprint: true)
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
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
        stage('Tests') {
              parallel {
                stage('Web Tests') {
                  agent {
                    kubernetes {
                      label 'nodejs-testcafe'
                      yaml testPodYaml
                    }
                  }
                  stages {
                    stage('Nodejs Setup') {
                      steps {
                        checkout scm
                        container('nodejs') {
                          sh '''
                            npm install express
                            npm install pug --save
                            node ./hello.js &
                          '''
                        }
                      }
                    }
                    stage('Testcafe') {
                      steps {
                        container('testcafe') {
                          sh '/opt/testcafe/docker/testcafe-docker.sh "chromium --no-sandbox" tests/*.js -r xunit:res.xml'
                        }
                      }
                    }
                  }
                  post {
                    success {
                      stash name: 'app', includes: '*.js, public/**, views/*, Dockerfile'
                    }
                    always {
                      junit 'res.xml'
                    }
                  }
                }
                stage('Load Test') {
                  agent {
                    kubernetes {
                      label 'nodejs-ab'
                      yaml loadTestPodYaml
                    }
                  }
                  stages {
                    stage('Nodejs Setup') {
                      steps {
                        checkout scm
                        container('nodejs') {
                          sh '''
                            npm install express
                            npm install pug --save
                            node ./hello.js &
                          '''
                        }
                      }
                    }
                    stage('Apache Benchmark') {
                      steps {
                        container('apache-benchmark') {
                          sh 'ab -n 10 -c 4 -s 5 http://localhost:8080/'
                        }
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
