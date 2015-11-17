node('docker') {

  checkout scm

  def branch = get_branch()
  echo "Current Branch ==> ${branch}"

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
  def dev_url = deploy_service(cluster, zone, img.id, 'dev')
  echo "DEV URL ==> ${dev_url}"

  // Deploy image to cluster in QA namespace
  stage 'Deploy to QA cluster'
  def staging_url = deploy_service(cluster, zone, img.id, 'staging')
  echo "STAGING URL ==> ${staging_url}"

  // Deploy to prod if approved
  stage 'Approve, deploy to prod'
  input message: "Does staging at $staging_url look good? ", ok: "Deploy to production"
  sh('gcloud docker -a')
  img.push('latest')
  def production_url = deploy_service(cluster, zone, img.id, 'production')
  echo "PRODUCTION URL ==> ${production_url}"

}

def get_branch() {
  def current_branch = ''

  // write current branch-name to file
  sh 'git branch -a --contains `git rev-parse HEAD` | grep origin | sed \'s!\\s*remotes/origin/\\(.*\\)!\\1!\' > git-branch.txt'

  // read data from file into environment-variable
  current_branch = readFile('git-branch.txt').trim()

  return current_branch

}

def deploy_service (cluster, zone, image_id, namespace) {
  echo "cluster ==> ${cluster}"
  echo "zone ==> ${zone}"
  echo "image_id ==> ${image_id}"
  echo "namespace ==> ${namespace}"

  docker.image('buildpack-deps:jessie-scm').inside {
    sh('apt-get update -y ; apt-get install jq')
    sh('export CLOUDSDK_CORE_DISABLE_PROMPTS=1 ; curl https://sdk.cloud.google.com | bash')
    sh("/root/google-cloud-sdk/bin/gcloud container clusters get-credentials ${cluster} --zone ${zone}")
    sh('curl -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v1.0.1/bin/linux/amd64/kubectl ; chmod +x /usr/bin/kubectl')
    sh("kubectl --namespace=dev rollingupdate gceme-frontend --image=${image_id}")
    sh("kubectl --namespace=dev rollingupdate gceme-backend --image=${image_id}")
    sh("echo http://`kubectl --namespace=dev get service/gceme-frontend --output=json | jq -r '.status.loadBalancer.ingress[0].ip'` > lb_url")
    def url = readFile('lb_url').trim()
    return url
  }

}