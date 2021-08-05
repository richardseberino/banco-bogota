pipeline {
    agent any
    environment {
        registry = "80190363/ibmace"
        registryCredential = 'dockerhub'
    }
    stages {
        
        stage('Build App Connect Enterprise Docker Image') {
            when { 
                branch 'master'
            }
            steps {
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                    
                }    
            }
        }
        
        stage('Push App Connect Enterprise Docker Image to Registry') {
            when {
                branch 'master'
            }
            steps {
                script {
                    docker.withRegistry( '', 'dockerhub' ) {
                        dockerImage.push()
                    }
                }
            }
        }   
        stage('Deploy App Connect Enterprise Openshift Container Platform') {
            when {
                branch 'master'
            }
            steps {
                script {
                    sh 'oc login --token=sha256~XAK3pLBbA7i4TAmqnIvl_XEo92pwxVR65HFsKtV71DU --server=https://c106-e.us-south.containers.cloud.ibm.com:31999'
                    sh 'oc project demo-bco-bogota'    
                    sh 'oc apply -f ace-openshift-deployment-bancamovil2.yaml'
                        }  
                }
            }
        }  
}
