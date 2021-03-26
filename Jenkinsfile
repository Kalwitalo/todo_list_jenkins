*PodTemplate*(label: 'maven-s', cloud: 'openshift', inheritFrom: 'maven', name: 'maven-s', volumes: [persistentVolumeClaim(mountPath: '/home/jenkins/.m2', claimName: 'dependencies', readOnly: false) ]) {
    node("maven-s") {
        stage('Source Checkout') {
            git url: "https://github.com/sagyvolkov/sagy-openshift-tasks.git"
            script {
                def pom = readMavenPom file: 'pom.xml'
                def version = pom.version
            }
        }
        // Using Maven build the war file
        stage('Build JAX-RS') {
            echo "Building war file"
            sh "mvn clean package -DskipTests=true"
        }
    }
}
