podTemplate(containers: [
    containerTemplate(name: 'maven', image: 'maven')
  ]) {
    node('nodejs') {
        stage('Run shell') {
            sh 'echo hello world'
        }
    }
}
