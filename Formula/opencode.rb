class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.13.4.tgz"
  sha256 "277a1ef78288f63e1de5fc98712640d0c51987fd1337bce4110983bd73acd0c5"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "74f54e22872353aaf0928c0d6c7dec4be2f79d2fe83c3961659350c3edc5b002"
    sha256                               arm64_sequoia: "956983b7972866480865f9e9500ce255f1c4b9a97938cca812bfeac6f1422219"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4898100fa5ceef10bb77c8c54c2d0fd5a552e53f8975a2830caa18c0581e83ba"
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
