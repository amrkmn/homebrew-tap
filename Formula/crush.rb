class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.9.2.tgz"
  sha256 "5471945ed9127113829ecbe3476fbfbfe04898ab0c423ad23d28c2ae2ce4f427"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "69c1a8b64c6deee4445d8892208d8472fe35d95260918e2c9f0c58c0509d3abd"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "254bc389b4bcb9aa60ef590d912b3f1c75334eefa773a56b67bb72e7680203b0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7b75651542922dcc75401d8ab8c2db1b00b0b47a093139a74685469f090b5400"
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
