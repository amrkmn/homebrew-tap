class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.10.0.tgz"
  sha256 "88580df7df1c9fb5b8556ba18cd3fc3e970870413bedf1a2030130d4c43cb387"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "22040795f2bd05c31660a75fcbaca2f7dd188a1517710848ac835e8efa60a8f9"
    sha256                               arm64_sequoia: "1429e0a7014c28afd643adbfee3b0f4f8fd4659b1b0e383e2e749800e34809f4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6d2bd9d279084c63c106b825e7d4f2e242bcc5182259f39872210f9ac96605c1"
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
