pipeline {
    agent any
    stages {
        stage('Initialize'){
            def dockerHome = tool 'docker'
            env.PATH = "${dockerHome}/bin:${env.PATH}"
        }
        stage('Push App Connect Enterprise Docker Image to Registry') {            
            steps {
                script {
                    // docker.withRegistry( '' ) {
                        def barImage = docker.build("demo-bco-bogota:${env.BUILD_ID}")
                        barImage.push('latest')
                    // }
                }
            }
        }   
        stage('Deploy App Connect Enterprise Openshift Container Platform') {
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
