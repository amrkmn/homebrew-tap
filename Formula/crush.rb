class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.10.1.tgz"
  sha256 "800c80cb6a85f3131069e9d766ea9cd7755f65e7360f86750615c4e477d86b5c"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "5d763c69a9253e30a0bcb934c3d2a076d1e08f76187b3b68dc5b0c2c4405edca"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "847252b07ff226da8d1e249a336a3c94809aa16de1fae15a302b99cd808132d0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3c3aefaa1ca23abe26185163351f13b3822f7e7a636d26ab548e81ef11a0fe27"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "crush version v#{version}", shell_output("#{bin}/crush --version")
  end
end
