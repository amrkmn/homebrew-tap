class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.46.tgz"
  sha256 "47c6c1414eabb65044ea4f2b47cd1486d802dd597a1d11674f47b15e2fb44ce8"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "36dfd2cf45407b3d6cc9b6221a6284aeac4c60ed49dfb0d64cabff0c702a8f39"
    sha256                               arm64_sequoia: "2e6fcb76c886d30c2415a7d0f9171a6197018f0f4951c92adaccc91aa8945352"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "80833a65690219f60cac1f62676d39e979897d34fcfad8fe4e4ea81b001439cf"
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
