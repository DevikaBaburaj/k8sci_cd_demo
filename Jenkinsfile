pipeline {
    agent any

    environment{
                DOCKER_LOGIN = credentials('doclogin')
            }

    stages {
        stage('Source') {
            steps {
                git branch: 'main', changelog: false, credentialsId: 'git_token', url: 'https://github.com/DevikaBaburaj/k8sci_cd_demo.git'
            }
        }
        stage('Build') {
            steps {
                sh '''
                docker build -t kubeimage .
                docker tag kubeimage devikababuraj/k8s-git-demo:${BUILD_NUMBER}
                echo "Image tagged"
                '''
            }
        }
        stage('Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'doclogin', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
                sh 'docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}'
                sh 'docker push devikababuraj/k8s-git-demo:${BUILD_NUMBER}'
                }
            }
        }

    }
}
