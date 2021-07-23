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

    stage('Compress application and ship to production site') {
      parallel {
        stage('Compress application and ship to production site') {
          steps {
            echo 'Compressing iBLIS and shipping to facility'
            sh '''[ -f $WORKSPACE/iBLIS.tar.gz] && echo "file already exists." ||       tar -czvf iBLIS.tar.gz $WORKSPACE/iBLIS
 '''
          }
        }

        stage('Shipping application and setup') {
          steps {
            echo 'Shipping to facility...'
            sh 'python3 iblis_shippingx.py'
          }
        }

      }
    }

  }
}