pipeline {
  agent any
  stages {
    stage('Initialising') {
      steps {
        echo 'Initialising pipeline'
      }
    }

    stage('Fetching iBLIS application') {
      parallel {
        stage('Fetching iBLIS application') {
          steps {
            echo 'Fetching application from github'
            sh '[ -d "iBLIS" ] && echo "iBLIS found, skipping cloning." || git clone https://github.com/HISMalawi/iBLIS.git iBLIS'
            sh 'cd $WORKSPACE/iBLIS |git fetch https://github.com/HISMalawi/iBLIS.git'
            sh '''echo "Adding permissions for the app to all users" chmod 777 $WORKSPACE/iBLIS
'''
          }
        }

        stage('copying .example files to .php') {
          steps {
            sh '[ -f "$WORKSPACE/iBLIS/app/config/kblis.php" ] && echo "kblis.php already exists." || cp $WORKSPACE/iBLIS/app/config/database.php.example $WORKSPACE/iBLIS/app/config/kblis.php |[ -f "$WORKSPACE/iBLIS/app/config/kblis.php" ] && echo "kblis.php already exists." || cp $WORKSPACE/iBLIS/app/config/database.php.example $WORKSPACE/iBLIS/app/config/database.php | [ -f "$WORKSPACE/iBLIS/app/config/app.php" ] && echo "app.php already exists." || cp $WORKSPACE/iBLIS/app/config/app.php.example $WORKSPACE/iBLIS/app/config/app.php'
          }
        }

      }
    }

    stage('fetching controller, data syncroniser') {
      parallel {
        stage('Fetching nlims_controller') {
          steps {
            echo 'Fetching nlims_controller from source code'
            sh '[ -d "nlims_controller" ] && echo "nlims_controller found, skipping cloning." || git clone https://github.com/HISMalawi/nlims_controller.git'
            sh '''echo "Adding permissions for the app to all users" chmod 777 $WORKSPACE/nlims_controller
'''
            sh 'cd $WORKSPACE/nlims_controller && git fetch --tags -f'
          }
        }

        stage('Fetching nlims_data_synchoniser') {
          steps {
            echo 'Fetching data syncroniser...'
            sh '[ -d "nlims_data_syncroniser" ] && echo "nlims_data_syncroniser found, skipping cloning." || git clone https://github.com/HISMalawi/nlims_data_syncroniser.git'
            sh 'cd $WORKSPACE/nlims_data_syncroniser && git fetch --tags -f'
            sh '''echo "Adding permissions for the app to all users" chmod 777 $WORKSPACE/nlims_data_syncroniser 
'''
          }
        }

      }
    }

    stage('Fetching Genexpert driver and lims-websocket') {
      parallel {
        stage('Fetching Genexpert') {
          steps {
            echo 'Fetching Genexpert driver'
            sh '[ -d "GeneXpert_Machine_Driver" ] && echo "GeneXpert Driver already cloned"|| git clone https://github.com/HISMalawi/GeneXpert_Machine_Driver.git'
            sh 'echo "Adding permissions for the app to all users" chmod 777 $WORKSPACE/GeneXpert_Machine_Driver'
          }
        }

        stage('Fetching lims_websocket') {
          steps {
            echo 'Cloning lims_websocket from repository'
            sh '''[ -d "lims-websocket" ] && echo "lims-websocket already cloned"|| git clone https://github.com/EGPAFMalawiHIS/lims-websocket.git
'''
            sh 'echo "Adding permissions for the app to all users" chmod 777 $WORKSPACE/lims_websocket'
          }
        }

      }
    }

    stage('Shipping applications & setup') {
      steps {
        echo 'Shipping iBLIS, nlims_controller, nlims_data_syncroniser, Genexpert drivers and lims-websocket'
        sh 'python3 shipping.py'
      }
    }

  }
}