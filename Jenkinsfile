stage 'Checkout'

node {
  checkout(scm)
  pack()
}

stage 'Tests'

parallel(
  knapsack(5) {
    withRbenv('2.1.8') {
      unpack()

      try {
        bundle()
        sh 'bundle exec rake knapsack:rspec'
      }
      finally {
        clearWorkspace()
      }
    }
  }
)


def knapsack(ci_node_total, cl) {
  def nodes = [:]

  for(int i = 0; i < ci_node_total; i++) {
    def index = i;

    nodes["ci_node_${i}"] = {
      node {
        withEnv(["CI_NODE_INDEX=$index", "CI_NODE_TOTAL=$ci_node_total"]) {
          cl()
        }
      }
    }
  }

  return nodes;
}
// Helper functions

def pack() {
    stash excludes: '.git/**/*', includes: '**/*', name: 'source'
    clearWorkspace()
}

def unpack() {
    clearWorkspace()
    unstash 'source'
}

def bundler() {
    sh "gem install bundler"
}

def bundle() {
    bundler()
    sh "bundle --quiet"
}

def clearWorkspace() {
    sh 'rm -rf *'
}

def withRbenv(version, cl) {
    withRbenv(version, "executor-${env.EXECUTOR_NUMBER}") {
        cl()
    }
}

def withRbenv(version, gemset, cl) {
    RBENV_HOME='$HOME/.rbenv'
    paths = [
        "$RBENV_HOME/bin",
        "$RBENV_HOME/shims",
        "$RBENV_HOME/plugins/ruby-build/bin",
        "${env.PATH}"
    ]

    def path = paths.join(':')

    withEnv([
        "PATH=$path"
    ]) {
        sh 'eval "$(rbenv init -)"'
        sh "rbenv global $version"
        cl()
    }
}
