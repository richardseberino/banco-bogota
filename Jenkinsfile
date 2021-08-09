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
   
   environment {
        APP = '${templateName}'
        NAMESPACE   = '${openshift.project()'
    }
   
  stages {
      
    stage('preamble') {
        steps {
            script {
                openshift.withCluster() {
                    openshift.withProject() {
                        echo "Using project: ${openshift.project()}"
                    }
                }
            }
        }
    }// end of stage 'preamble'
    
    stage('cleanup') {
      steps {
        script {
            openshift.withCluster() {
                openshift.withProject() {
                  withEnv(["PATH+OC=${tool 'oc.3.11.0'}"]){
                  sh 'oc get all --selector app=dev-bogota-ops -o name'
                  openshift.selector("all", [ app : templateName ]).delete() 
                  if (openshift.selector("secrets", templateName).exists()) { 
                    openshift.selector("secrets", templateName).delete()
                  }
                  sh 'oc get all --selector app=dev-bogota-ops -o name'
                  echo "Cleanup done"
                }
                }
            }
        }
      }
    } // end of stage 'cleanup'
    
    stage('deployment') {
      steps {
        script {
            openshift.withCluster() {
                openshift.withProject() {
                    withEnv(["PATH+OC=${tool 'oc.3.11.0'}"]){
                      echo 'Create deployment from yaml files'
                      sh 'oc apply -f 01-detalleproducto-deployment.yaml'
                    }
                }
            }
        }
      }
    }// end of stage 'deployment'
    
     stage('service') {
        steps {
          script {
              openshift.withCluster() {
                  openshift.withProject() {
                      withEnv(["PATH+OC=${tool 'oc.3.11.0'}"]){
                        sh 'oc apply -f 02-detalleproducto-service.yaml'
                        def builds = openshift.selector("bc", templateName).related('builds')
                        if (openshift.selector("service", templateName).exists()) { 
                          sh 'echo service created'
                          }
                      }
                  }
              }
          }
        }
    }// end of stage 'service'
    
    stage('route') {
        steps {
          script {
              openshift.withCluster() {
                  openshift.withProject() {
                      withEnv(["PATH+OC=${tool 'oc.3.11.0'}"]){
                        sh 'oc apply -f 03-detalleproducto-route.yaml'
                        sh 'oc apply -f 04-detalleproducto-route-webgui.yaml'
                      }
                  }
              }
          }
        }
    }// end of stage 'route'
    
    stage('autoscaler') {
        steps {
          script {
              openshift.withCluster() {
                  openshift.withProject() {
                      withEnv(["PATH+OC=${tool 'oc.3.11.0'}"]){
                        sh 'oc apply -f 05-detalleproducto-horizontal-autoscaler.yaml'
                      }
                  }
              }
          }
        }
    }// end of stage 'autoscaler'
  }  
}