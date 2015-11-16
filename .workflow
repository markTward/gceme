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

  // Kubernetes cluster info
  def cluster = 'gtc'
  def zone = 'us-central1-f'
  def project = 'agile-axe-427'

 // Build image with Go binary
  stage 'Build Docker image'
  def img = docker.build("gcr.io/${project}/gceme:${env.BUILD_TAG}")
  sh('gcloud docker -a')
  img.push()

  // Deploy image to cluster in DEV namespace
  stage 'Deploy to DEV cluster'
  docker.image('buildpack-deps:jessie-scm').inside {
    sh('apt-get update -y ; apt-get install jq')
    sh('export CLOUDSDK_CORE_DISABLE_PROMPTS=1 ; curl https://sdk.cloud.google.com | bash')

    sh("/root/google-cloud-sdk/bin/gcloud container clusters get-credentials ${cluster} --zone ${zone}")
    sh('curl -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v1.0.1/bin/linux/amd64/kubectl ; chmod +x /usr/bin/kubectl')

    sh("kubectl --namespace=dev rollingupdate gceme-frontend --image=${img.id}")
    sh("kubectl --namespace=dev rollingupdate gceme-backend --image=${img.id}")

    sh("echo http://`kubectl --namespace=dev get service/gceme-frontend --output=json | jq -r '.status.loadBalancer.ingress[0].ip'`")
  }

}