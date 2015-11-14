node('docker') {

  echo 'workflow tutorial!'

  // jenkins info
  echo "${env.BUILD_TAG}"

  // SCM info
  checkout scm

  echo "${env.GIT_URL}"
  echo "${env.GIT_BRANCH}"
  echo "${env.GIT_COMMIT}"

}