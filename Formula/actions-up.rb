class ActionsUp < Formula
  desc "Interactive CLI tool to update GitHub Actions"
  homepage "https://github.com/azat-io/actions-up"
  url "https://registry.npmjs.org/actions-up/-/actions-up-1.17.1.tgz"
  sha256 "211923458c417416df951da425f7696c835faf38cf684e1a02eb4a606c101998"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "69db72c8173afd07aa6a4110323fa6c5b5cd8290686c6bcef11fb75813366281"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "1c77048cfb0b5858f6615a751d09c37aeb03fd69b9871b61e382fe7b8cf00e7e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b8c3ee762e7be286a9938cf784e3da09210958b921b4b58f9f24067c91f2a09b"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/actions-up --version")
  end
end
