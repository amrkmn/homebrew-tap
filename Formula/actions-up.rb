class ActionsUp < Formula
  desc "Interactive CLI tool to update GitHub Actions"
  homepage "https://github.com/azat-io/actions-up"
  url "https://registry.npmjs.org/actions-up/-/actions-up-1.4.2.tgz"
  sha256 "4ee181ad3eb8eda9ca4543ce6ba1244453ee4888bab7aefbe11d6b06b93d8708"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "29af32673db20e6e9adf8f21c04fca1962dd732ca1402305b27b07735010b88a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e19adf8452cc27b5af374606d54f3232919b330a4296d7e86353af8fd16321f9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e1e9d643bcc222c39043d6d6517e4361da41ba59d4d78a27b2b20239776b2556"
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
