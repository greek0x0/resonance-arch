pipeline {
    agent any

    stages {
        stage("build") {
            steps {
                echo 'Building the ISO'
            }
        }
        stage("test"){
            steps {
                echo 'Testing the ISO in qemu'
            }
        }
        stage ("deploy") {
            steps {
                echo 'Installing the OS'

            }
        }
    }
}
