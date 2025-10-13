class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.11.0.tgz"
  sha256 "dffaa51185d3e0e0a2223c593dc3d2eae908a7e36df752672cbdb7f856c935d2"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "0d82b57ef1141d88c5b4323680d623b2f02ac1d963fd882d2f29b582e6f0038f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "120848acabfe9a363d4c009e8a02e2a38b56d6d3c9ce80f3ee56f923941e93f3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b7ad0c0b8f309f41cd3d04b3e05704806ad26925c386e70d4112a68da12678f4"
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
