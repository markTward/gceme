node('docker') {

  checkout scm

  def branch = get_branch()
  echo "Current Branch ==> ${branch}"

/*
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

  // Deploy image to cluster in QA namespace
  stage 'Deploy to QA cluster'
  docker.image('buildpack-deps:jessie-scm').inside {
    sh('apt-get update -y ; apt-get install jq')
    sh('export CLOUDSDK_CORE_DISABLE_PROMPTS=1 ; curl https://sdk.cloud.google.com | bash')
    sh("/root/google-cloud-sdk/bin/gcloud container clusters get-credentials ${cluster} --zone ${zone}")
    sh('curl -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v1.0.1/bin/linux/amd64/kubectl ; chmod +x /usr/bin/kubectl')
    sh("kubectl --namespace=staging rollingupdate gceme-frontend --image=${img.id}")
    sh("kubectl --namespace=staging rollingupdate gceme-backend --image=${img.id}")
    sh("echo http://`kubectl --namespace=staging get service/gceme-frontend --output=json | jq -r '.status.loadBalancer.ingress[0].ip'` > staging")
  }

  // Deploy to prod if approved
  stage 'Approve, deploy to prod'
  def url = readFile('staging').trim()
  input message: "Does staging at $url look good? ", ok: "Deploy to production"
  sh('gcloud docker -a')
  img.push('latest')
  docker.image('buildpack-deps:jessie-scm').inside {
    sh('apt-get update -y ; apt-get install jq')
    sh('export CLOUDSDK_CORE_DISABLE_PROMPTS=1 ; curl https://sdk.cloud.google.com | bash')
    sh("/root/google-cloud-sdk/bin/gcloud container clusters get-credentials ${cluster} --zone ${zone}")
    sh('curl -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v1.0.1/bin/linux/amd64/kubectl ; chmod +x /usr/bin/kubectl')
    sh("kubectl --namespace=production rollingupdate gceme-frontend --image=${img.id}")
    sh("kubectl --namespace=production rollingupdate gceme-backend --image=${img.id}")
    sh("echo http://`kubectl --namespace=production get service/gceme-frontend --output=json | jq -r '.status.loadBalancer.ingress[0].ip'`")
  }
*/

}

def get_branch() {
  def current_branch = ''

  // write current branch-name to file
  sh 'git branch -a --contains `git rev-parse HEAD` | grep origin | sed \'s!\\s*remotes/origin/\\(.*\\)!\\1!\' > git-branch.txt'

  // read data from file into environment-variable
  current_branch = readFile('git-branch.txt').trim()
  echo "in get_branch(). current_branch ==> ${current_branch}"
  current_branch

}