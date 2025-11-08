class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.46.tgz"
  sha256 "47c6c1414eabb65044ea4f2b47cd1486d802dd597a1d11674f47b15e2fb44ce8"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "d8ce1274598466a923a2a8eff3598583a19b028d4d492a692816a94ec5f9d31c"
    sha256                               arm64_sequoia: "7c6c830b79da2e2aae73b0a8165640e49cc3e5ed75245bd90ec064be52cc5711"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e8b1a89235e2911c88b51a160bad1c8f2770821125a25a3c249d7abf65ef9d4a"
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
