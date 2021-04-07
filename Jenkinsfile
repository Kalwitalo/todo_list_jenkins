pipeline {
agent any
stages {
    stage('Parallel Tests') {
        parallel {
            stage('Ordered Tests Set') {
                stages {
                    stage('Building seq test 1') {
                        steps {
                             echo "build seq test 1"
                            }
                    }
                    stage('Building seq test 2') {
                        steps {
                               echo "build seq test 2"
                        }
                    }

                }
            }

            stage('Building Parallel test 1') {
                steps {
                    echo "Building Parallel test 1"
                }
            }
            stage('Building Parallel test 2') {
                steps {
                   echo "Building Parallel test 2"
                }
            }
        }

    }
}
}
