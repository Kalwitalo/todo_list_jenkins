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

    stage('Preamble') {
      when {
        expression {
          openshift.withCluster() {
            return !openshift.selector("project", "${projectOpenshiftName}").exists()
          }
        }
      }
      steps {
        script {
          openshift.withCluster() {
            openshift.newProject("${projectOpenshiftName}")
          }
        }
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

  }
  environment {
    appName = 'todolist'
    projectOpenshiftName = 'kalwitalo'
  }
}
