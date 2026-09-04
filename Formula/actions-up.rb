class ActionsUp < Formula
  desc "Interactive CLI tool to update GitHub Actions"
  homepage "https://github.com/azat-io/actions-up"
  url "https://registry.npmjs.org/actions-up/-/actions-up-1.19.0.tgz"
  sha256 "c9131501b65ea561cc38096e658f63210f26d80baffb8512835cec2f717aea6d"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "e805ab21ee052cb00414e97fa83eadab2a1cd2fd2a692afd3b8e7dafe27487ad"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "d4f03151a239aca3cde1aecc8edd38a970aef9104b73429712c359ba3896e9e0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2ce3d8772a63944b49b9bf762d4a4b87eac41930469ebdf94397a85ee280e8f2"
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
