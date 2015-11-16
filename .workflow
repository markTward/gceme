node('docker') {

  echo 'hello docker workflow'

  // checkout repo
  git url: 'https://github.com/markTward/gceme.git', branch: 'dev'

  // Run tests
  stage 'Go tests'
  docker.image('golang:1.5.1').inside {
    sh('go get -d -v')
    sh('go test')
  }

}