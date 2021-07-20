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

        stage('Checkout to development_1.0') {
          steps {
            sh '      cd $WORKSPACE/iBLIS|git checkout -f   master'
          }
        }

        stage('copying .example files to .php') {
          steps {
            sh '[ -f "$WORKSPACE/iBLIS/app/config/kblis.php" ] && echo "kblis.php already exists." || cp $WORKSPACE/iBLIS/app/config/database.php.example $WORKSPACE/iBLIS/app/config/kblis.php |[ -f "$WORKSPACE/iBLIS/app/config/kblis.php" ] && echo "kblis.php already exists." || cp $WORKSPACE/iBLIS/app/config/database.php.example $WORKSPACE/iBLIS/app/config/database.php | [ -f "$WORKSPACE/iBLIS/app/config/app.php" ] && echo "app.php already exists." || cp $WORKSPACE/iBLIS/app/config/app.php.example $WORKSPACE/iBLIS/app/config/app.php'
          }
        }

        stage('Fetching composer installation file') {
          steps {
            sh '[ -f "$WORKSPACE/iBLIS/composer.phar" ] && echo "composer.phar already exists." || curl https://github.com/DoxDevOps/lims-setup/blob/master/composer.phar > $WORKSPACE/iBLIS/composer.phar'
          }
        }

      }
    }

    stage('Fetching php and dependencies') {
      steps {
        echo 'Fetch php and dependencies  located in debs folder'
        sh '[ -d "$WORKSPACE/iBLIS/debs" ] && echo "debs already exists." || curl https://github.com/DoxDevOps/lims-setup/tree/master/debs > $WORKSPACE/iBLIS/debs'
      }
    }

    stage('Compress application and ship to production site') {
      steps {
        echo 'Compressing iBLIS and shipping to facility'
      }
    }

  }
}