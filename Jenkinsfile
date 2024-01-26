pipeline {
    environment {
        registry = "imanelo/nginx"
        registryCredential = 'dockerHub'  // Use the correct credential ID
        GITHUB_ACCESS_TOKEN = credentials('Github-Jenkins') // Use correct credential ID
    }
    agent any
    
    stages {
        stage('Cleanup Workspace') {
            steps {
                script {
                    // remove the PushDockerImages subdirectory
                    sh 'rm -rf PushDockerImages'
                }
            }
        }
        stage('Cloning our Git') {
            steps {
                script {
                    sh "git clone https://github.com/Imanelo/PushDockerImages.git"
                }
            }
        }
        stage('Building our image') {
            steps {
                script {
                    // Build the Docker image and tag it
                    //sh "dockerImage=\$(docker build -q -t \${registry}:\${BUILD_NUMBER} .)"
                    sh "docker build -q -t \${registry}:\${BUILD_NUMBER} ."

                }
            }
        }
        stage('Push our image') {
            steps {
                 script {
                     withCredentials([usernamePassword(credentialsId:registryCredential, usernameVariable: 'HUB_USERNAME', passwordVariable: 'HUB_PASSWORD')]) {
                        // Push the Docker image to the registry
                        sh "docker login -u \${HUB_USERNAME} -p \${HUB_PASSWORD}"
                        sh "docker push \${registry}:\${BUILD_NUMBER}"
                        
                     }
                }
            }
        }
        stage('Cleaning up') {
            steps {
                script {
                    // Clean up by removing the local Docker image
                    sh "docker rmi \${registry}:\${BUILD_NUMBER}"
                }
            }
        }
    }
}

