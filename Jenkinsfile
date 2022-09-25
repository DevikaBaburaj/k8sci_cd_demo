pipeline {
    agent any

    environment{
                DOCKER_LOGIN = credentials('doclogin')
            }

    stages {
        stage('Source') {
            steps {
                git branch: 'batch-4', changelog: false, credentialsId: 'token1', poll: false, url: 'https://github.com/DevikaBaburaj/spring-boot-jsp.git'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('Build') {
            steps {
                sh 'docker build -t registry/kubeimage .'
            }
        }
        stage('Push') {
            steps {
                sh '''
                docker tag kubeimage registry/kubeimage.${BUILD_NUMBER}
                echo $DOCKER_LOGIN_PSW | docker login -u $DOCKER_LOGIN_USR --password-stdin
                docker push registry/kubeimage.${BUILD_NUMBER}
                '''
            }
        }
        stage('Copying Artifcats') {
            environment{
                PUB_KEY = credentials('pubkey')
            }
            steps {
                    sh '''
                    version=$(perl -nle 'print "$1" if /<version>(v\\d+\\.\\d+\\.\\d+)<\\/version>/' pom.xml)
                    rsync -e "ssh -o StrictHostKeyChecking=no -i ${PUB_KEY}" -arvc target/news-${version}.jar ubuntu@65.0.92.160:~/
                    '''
            }
        }
    }
}