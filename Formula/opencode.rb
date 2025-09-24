class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.11.3.tgz"
  sha256 "82f911dcb05754e29cc6502a220ab4e34fe45b9e42fd52bec2f2b115ad2f1883"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "96f15a910916dd372e54132ed90cd6568a49b364d7f55d5fb0e0a8ce15d30898"
    sha256                               arm64_sequoia: "33edec278ad79ded2cba0e3bd69567eb826d55ae846f2be933c952fc5e5607f8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "889efd46b55eead22e2fe91546cf444d21621fb7b127041f707d9168a899fa2f"
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
