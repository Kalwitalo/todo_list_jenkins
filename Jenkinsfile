pipeline {
  agent {
    kubernetes {
      cloud 'openshift'
    }
  }

  node(label: 'maven') {
    sh 'ls -lu'
  }

}
