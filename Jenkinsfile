node('docker') {
  echo 'starting WorkFlow!!!'

  checkout scm

  // Kubernetes cluster info
  def cluster = 'gtc'
  def zone = 'us-central1-f'
  def project = 'agile-axe-427'

  // Run tests
  stage 'Go tests'
  docker.image('golang:1.5.1').inside {
    sh('go get -d -v')
    sh('go test')
  }

  // Build image with Go binary
  stage 'Build Docker image'
  def img = docker.build("gcr.io/${project}/gceme:${env.BUILD_TAG}")
  sh('gcloud docker -a')
  img.push()

}