node('docker') {
    echo 'docker k8s workflow world!'
    echo 'test git pull'
    //git url: 'https://github.com/markTward/gceme.git', branch: 'dev'
    
    stage 'Go tests'
    docker.image('golang:1.5.1').inside {
        echo 'inside docker.image'
        sh 'uname -a'
        sh('go get -d -v')
        sh('go test')
    }

  // Build image with Go binary
  stage 'Build Docker image'

  docker.withRegistry('https://dtr.sj.lithium.com', 'dtr_li_marktward') {
      echo 'inside docker.withRegistry'
      def img = docker.build("marktward/gceme:latest")
      img.push()
  }

}
