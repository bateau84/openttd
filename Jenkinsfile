#!/usr/bin/env groovy
pipeline {
    agent any
  
    options {
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }

    triggers {
        cron('H H 1,15,30 1-11 *')
        pollSCM('H/1 * * * *')
    }

    environment {
        DOCKER_REGISTRY = 'index.docker.io/'
        DOCKER_REPOSITORY = 'bateau'
        DOCKER_IMAGE_NAME = 'openttd'
        DOCKER_ARGS = '--no-cache --squash '
        RELEASE_FILE = 'releases'
        GIT_COMMIT_ID = sh(returnStdout: true, script: "git rev-parse --short HEAD").trim()
        GIT_BRANCH = sh(returnStdout: true, script: "git rev-parse --abbrev-ref HEAD").replace(" ", "-").replace("/", "-").replace(".", "-")
    }
    
    stages {
        stage('Prepare') {
            steps {
                echo 'Preparing the build environment'
                checkout scm
            }
        }

        stage('Branch Build') {
            when {
                not {
                    branch 'master'
                }
            }
            steps {
                script {
                    def baseimage = docker.build("${env.DOCKER_REGISTRY}${env.DOCKER_REPOSITORY}/${env.DOCKER_IMAGE_NAME}:${env.GIT_BRANCH}-${env.GIT_COMMIT_ID}", "${env.DOCKER_ARGS}.")
                    baseimage.push()
                    env.imageName = baseimage.imageName()
                }
            }
        }

        stage('Master Build') {
            when {
                branch 'master'
            }

            steps {
                script {
                    def LINES = new File(env.WORKSPACE, env.RELEASE_FILE).readLines()

                    for(int i = 0; i < LINES.size(); i++) {    
                        echo "[ "+LINES[i]+" ]"
                        
                        def baseimage = docker.build("${env.DOCKER_REGISTRY}${env.DOCKER_REPOSITORY}/${env.DOCKER_IMAGE_NAME}:${LINES[i]}", "--build-arg OPENTTD_VERSION=${LINES[i]} ${env.DOCKER_ARGS}.")
                        baseimage.push()

                        if (i == 0){
                            baseimage.push("latest")
                        }
                    }
                }
            }
        }
    }
    post {
        always {
            deleteDir()
        }
    }
}
