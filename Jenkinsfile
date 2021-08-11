def templateName = 'dev-bogota-ops'


pipeline {
    
  agent {
    node {
      label 'container-tools' 
    }
  }
  
  options{
        timeout(time: 15, unit: 'MINUTES')
   }
   
   tools {
     oc 'oc-client'
   }

   environment {
        APP = '${templateName}'
        NAMESPACE   = '${openshift.project()'
        // DOCKER = "${dockerTool}/bin"
    }
   
  stages {
      
                        
    
    stage('deployment') {
      steps {
        script {
            openshift.withCluster() {
                openshift.withProject() {
                    // withEnv(["PATH+OC=${tool 'oc-client'}"]){
                      echo 'Create integration server'
                      sh 'oc apply -f integration-server.yaml'
                    // }
                }
            }
        }
      }
    }// end of stage 'deployment'
    
  }  
}