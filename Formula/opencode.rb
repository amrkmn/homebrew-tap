class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.22.tgz"
  sha256 "cb250c7824553e3917f3a73cb85b8dde61c021eddcdfb40a04cdce11170a2a6f"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "23a2bb1ebe1d54fa89d095c0c5abd1972d8533bf8e66a7385b75a08b1a93a6eb"
    sha256                               arm64_sequoia: "0525e9d219f55d622790ef75cc5515b9a0504b666773bbf3c74761da8fb893b2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b50c1768629f074f720cea8ff1db948508539bea22288cb5016749a769dd0711"
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
