pipeline {
  agent {
    kubernetes {
      cloud 'openshift'
    }
  }

  node(label: 'maven') {
    stage("One"){
        sh 'ls -lu'
    }
  }

}
