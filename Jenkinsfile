node {
  try {
    stage('Checkout') {
      checkout scm
    }
    stage('Environment') {
      sh 'git --version'
      echo "Branch: ${env.BRANCH_NAME}"
      sh 'docker -v'
      sh 'printenv'
    }
    stage('Build Docker test'){
     sh 'docker build -t huglass -f Dockerfile.test --no-cache .'
    }
    stage('Docker test'){
      sh 'docker run --rm huglass'
    }
    stage('Clean Docker test'){
      sh 'docker rmi huglass'
    }
    stage('Deploy'){
      if(env.BRANCH_NAME == 'main'){
        sh 'docker build -t huglass --no-cache .'
        sh 'docker tag huglass localhost:5000/huglass'
        sh 'docker push localhost:5000/huglass'
        sh 'docker rmi -f huglass localhost:5000/huglass'
      }
    }
  }
  catch (err) {
    throw err
  }
}