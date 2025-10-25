class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.15.17.tgz"
  sha256 "081d59aef4db9522dcacdd1e1a0c16d5d0fc27216cea72e5806ee1c2d8e0dcca"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "6c36467e052f9cc1161a65f14648ed704703e14644731fd79b2b776a4f7df027"
    sha256                               arm64_sequoia: "8c501123de59947d62417bc209c1a260daadf689e3836c03416d761738f7f387"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "125f2221a78335eb9abd2e7ca4cb6d7e1fccec74cd04e56e20e4d5eb2c9a14b4"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/opencode --version")
    assert_match "opencode", shell_output("#{bin}/opencode models")
  end
end
