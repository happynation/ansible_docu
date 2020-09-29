pipeline {
    agent any
    options {
        ansiColor('xterm') 
    }

    // stages {
    //     stage('PWD') {
    //         steps {
    //             sh '''
    //             pwd
    //             whoami
    //             echo 'Hello Vova'
    //             sudo ansible -m ping -i /var/lib/jenkins/dev_inventory dev
    //             '''
    //         }
    //     }
        stage('Run playbook') {
            steps {
                sh 'sudo ansible-playbook rolevariable.yaml -i /var/lib/jenkins/dev_inventory -e "role=$ROLE name=$NAME uid=$UID"'
            }
        }
    }
    post {
        always {
            cleanWs()
            chuckNorris()
        }
    }
}