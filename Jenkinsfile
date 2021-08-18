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
         // This can be nexus3 or nexus2
        NEXUS_VERSION = "nexus3"
        // This can be http or https
        NEXUS_PROTOCOL = "http"
        // Where your Nexus is running
        NEXUS_URL = "nexus-route-openshift-operators.cp-poc-510ad6ebead8e7457a6e62904edfa48f-0000.us-south.containers.appdomain.cloud/"
        // Repository where we will upload the artifact
        NEXUS_REPOSITORY = "releases"
        // Jenkins credential id to authenticate to Nexus OSS
        NEXUS_CREDENTIAL_ID = "nexus-credentials"
        IMAGE_VERSION = '${BUILD_NUMBER}'
    }
   
  stages {
      
    stage("publish to nexus") {
            steps {
                script {
                        nexusArtifactUploader(
                            nexusVersion: NEXUS_VERSION,
                            protocol: NEXUS_PROTOCOL,
                            nexusUrl: NEXUS_URL,
                            groupId: "BARfiles",
                            version: IMAGE_VERSION,
                            repository: NEXUS_REPOSITORY,
                            credentialsId: NEXUS_CREDENTIAL_ID,
                            artifacts: [
                                [artifactId: "bco-bogota",
                                classifier: '',
                                file: "BARfiles/TESTBAR.bar",
                                type: "bar"]
                            ]
                        );
                }
            }
        }
    
    stage('deployment') {
      steps {
        script {
            openshift.withCluster() {
                openshift.withProject() {  
                  echo 'Create integration server'
                  sh 'sed -i \'s/latest/\'${BUILD_NUMBER}\'/g\' integration-server.yaml'
                  sh 'oc apply -f integration-server.yaml'
                }
            }
        }
      }
    }// end of stage 'deployment'
  }  
}