class ActionsUp < Formula
  desc "Interactive CLI tool to update GitHub Actions"
  homepage "https://github.com/azat-io/actions-up"
  url "https://registry.npmjs.org/actions-up/-/actions-up-1.21.0.tgz"
  sha256 "31cfb104f6354c1880b826f34fba6da522152cf71367f700abe10e2a262f47ae"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "96581bbfc3b70c93f7f2237cee79b1009549d3a9205c287a2e66efcd59498089"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "edd67eb1696153e00eea4d43bd0c41dfcea6ae801cb0d82891525c63f55cb030"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8aa18f6e48c7af35b95386a33a520ea22e34ee09e81eebcc4661b4169146a1c5"
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
