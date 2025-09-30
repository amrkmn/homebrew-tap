class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.10.4.tgz"
  sha256 "e76e65454e5dea9e6e2529c3629da8cdd7d0e6dd8f5aa9ed8ed5df65bfa35593"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "064b8157242c2970c502534dd44975bee2605cab63183a08238277ad1da09a34"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4c74be6ce280699522908697d8c30f2cf9238e615895345c7efb7c208d0a19d2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e7ed04d8aa7f59a21e1ba007fc7cb69989d6cd2b61dad7a408bd309d8bdd19a4"
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
