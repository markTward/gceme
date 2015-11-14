node('docker') {

  echo 'workflow tutorial!'

  // jenkins info
  echo "BUILD_TAG ==> ${env.BUILD_TAG}"

  // SCM info
  checkout scm

  echo "SVN_URL ==> ${env.SVN_URL}"
  //echo "${env.GIT_BRANCH}"
  //echo "${env.GIT_COMMIT}"

}