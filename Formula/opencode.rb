class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.15.31.tgz"
  sha256 "7b6b44e2a6985d9fc1ade95ca2f5af7e301879682fe815cd2a0015ce3ea78a1e"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "de8596960861b9732fc794f7d0e74833e5aaed11e3f0b34e6fcdf25bd4dfe902"
    sha256                               arm64_sequoia: "0f76763a99a32da5e2bc67f35c52deacafb06b825563a732635a59490b75d24a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "babb66c8ba87fbc3c06fadf7e7a54eff8c6d3af1e01939cf6bde07c7972f7662"
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
