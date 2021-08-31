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

        stage('Fetching nlims_controller') {
          steps {
            echo 'Fetching nlims_controller from github'
            sh '[ -d "nlims_controller" ] && echo "nlims_controller found, skipping cloning." || git clone https://github.com/HISMalawi/nlims_controller.git'
          }
        }

      }
    }

    stage('Compress application and ship to production site') {
      parallel {
        stage('Compress application and ship to production site') {
          steps {
            echo 'Compressing iBLIS and shipping to facility'
            sh 'echo "compressing iBLIS application" '
          }
        }

        stage('Shipping application and setup') {
          steps {
            echo 'Shipping to facility...'
          }
        }

        stage('error') {
          steps {
            echo 'shipping application to facility'
          }
        }

      }
    }

  }
}