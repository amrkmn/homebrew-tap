class ActionsUp < Formula
  desc "Interactive CLI tool to update GitHub Actions"
  homepage "https://github.com/azat-io/actions-up"
  url "https://registry.npmjs.org/actions-up/-/actions-up-1.15.0.tgz"
  sha256 "80c158ce2566661e211d3df75414525f868d1785ba40571fa62a7b2a45f4a888"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "7ce6789cbe802a9e94eaf7aeb7f06cabdc73010a5bd73ec27d0b7894bd1442ac"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "03486d2dbbec3daea0e366826fb0752ce7475549fd4b750796da015e8de4268a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7f52a8f5a0805429c81e350e290a4724705b484c4e62b327bdeabeb798e40673"
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
