#!/bin/bash


jenkins_user=$1
jenkins_password=$2
jenkins_address=http://localhost:8080

set -x

function installing()
{
    sudo apt-get update
    sudo apt install openjdk-11-jre
    
    curl -fsSL https://pkg.jenkins.io/debian/jenkins.io.key | sudo tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt-get update -y
    sudo apt-get install jenkins
    sleep 1
    echo "[INFO]  Jenkins was installed"
}

function startup()
{
    sudo systemctl start jenkins &
    
    while (( 1 )); do
      echo "[INFO]   waiting for Jenkins "
      sudo  wget $jenkins_address/jnlpJars/jenkins-cli.jar
      if (( $? == 0 )); then
          break
      fi
      sleep 20
    done
    
    #Installing jenkins CLI
    sudo  wget $jenkins_address/jnlpJars/jenkins-cli.jar
    
    echo "[INFO]   Jenkins was thrown"
}

function user_add()
{
    #Installing jenkins CLI
    sudo  wget $jenkins_address/jnlpJars/jenkins-cli.jar
    initialAdminPassword=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)
    echo "jenkins.model.Jenkins.instance.securityRealm.createAccount('$jenkins_user', '$jenkins_password')" | java -jar jenkins-cli.jar -auth admin:$initialAdminPassword -s $jenkins_address/ groovy =
    
    echo "[INFO]   user is registered"
}

function plugins()
{
    ls -trals
    #Installing jenkins plugins 
    # TOP 10 of our favorite Jenkins plugins
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password install-plugin blueocean:1.25.6
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password install-plugin simple-theme-plugin:103.va_161d09c38c7
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin perfpublisher:8.09
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin github:1.34.5
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin kubernetes:3690.va_9ddf6635481
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin dashboard-view:2.447.vda_124dd35f11
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin maven-plugin:3.19
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin cloudbees-folder:6.758.vfd75d09eea_a_1
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin bootstraped-multi-test-results-report:2.2.1
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin pipeline-utility-steps:2.13.0
    java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin octopusdeploy:3.1.7


    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin trilead-api
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin cloudbees-folder
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin antisamy-markup-formatter
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin jdk-tool
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin structs
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin workflow-step-api
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin token-macro
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin build-timeout
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin credentials
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin plain-credentials
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin ssh-credentials
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin credentials-binding
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin scm-api
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin workflow-api
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin timestamper
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin script-security
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin workflow-support
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin durable-task
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin workflow-durable-task-step
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin plugin-util-api
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin font-awesome-api
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin popper-api
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin jquery3-api
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin bootstrap4-api
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin snakeyaml-api
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin jackson2-api
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin echarts-api
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin junit
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin matrix-project
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin command-launcher
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin resource-disposer
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin ws-cleanup
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin ant
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin bouncycastle-api
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin ace-editor
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin jquery-detached
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin workflow-scm-step
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin workflow-cps
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin workflow-job
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin apache-httpcomponents-client-4-api
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin display-url-api
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin mailer
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin workflow-basic-steps
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin gradle
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin pipeline-milestone-step
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin pipeline-input-step
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin pipeline-stage-step
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin pipeline-graph-analysis
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin pipeline-rest-api
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin handlebars
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin momentjs
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin pipeline-stage-view 
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin pipeline-build-step
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin pipeline-model-api
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin pipeline-model-extensions
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin jsch
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin git-client
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin git-server
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin workflow-cps-global-lib
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin branch-api
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin workflow-multibranch
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin pipeline-stage-tags-metadata
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin pipeline-model-definition
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin lockable-resources
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin workflow-aggregator
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin okhttp-api
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin github-api
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin git
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin github
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin github-branch-source
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin pipeline-github-lib 
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin ssh-slaves
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin pam-auth 
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin ldap
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin email-ext 
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin checks-api
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin jjwt-api
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin matrix-auth
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin ssh
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin role-strategy
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin javadoc
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin job-dsl
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin maven-plugin
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin strict-crumb-issuer
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin kubernetes:3690.va_9ddf6635481
    # java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  install-plugin blueocean:1.25.6

    # Restart
    sudo systemctl restart jenkins &
    while (( 1 )); do
      echo "[INFO]   waiting for restart Jenkins on port [8080] ..."
      
      java -jar jenkins-cli.jar -s "$jenkins_address" -auth $jenkins_user:$jenkins_password  list-jobs
      if (( $? == 0 )); then
          break
      fi
    
      sleep 20
    done
    
    echo "[INFO]   Jenkins was restarted"
}
###########################################################################
# Main function 
###########################################################################

    installing
    
    startup
    
    user_add
    
    plugins
     
exit 0