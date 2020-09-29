pipeline {
  agent any
  stages {
    stage('init') {
      steps {
        dir("terraform/") {
          sh 'sudo terraform init'
        }
      }
    }
    stage('plan') {
      steps {
        dir("terraform/") {
          sh 'sudo terraform plan -var-file=vova.tfvars'
        }
      }
    }
    stage('apply') {
      steps {
        dir("terraform/") {
          sh 'sudo terraform $CHOICE -var-file=vova.tfvars -auto-approve'
        }
      }
    }
    stage('destroy') {
      steps {
        dir("terraform/") {
          sh 'sudo terraform $CHOICE -var-file=vova.tfvars -auto-approve'
        }
      }
    }
  }    
  post {
    always {
      chuckNorris()
    }
  }
}