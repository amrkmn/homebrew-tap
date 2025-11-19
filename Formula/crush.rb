class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.18.3.tgz"
  sha256 "70434ec4168a354de9b1973fee129e83e49019418a2e1a757dd8892df93f610d"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "ccb55470db1fb081b557d4509748815344dbd87347aa79183ebccfd0061939b6"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9adcb1e1f40d1a03955b6df91e20fa9c2c286c9a5ea9a831008de271540bfbf6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5c93cf031e54c7cb6dd0cc80d68ad8ced4ec09a56c4ea1a5f0ff7ce292c3b7a9"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]

    generate_completions_from_executable(bin/"crush", "completion")
  end

  test do
    assert_match "crush version v#{version}", shell_output("#{bin}/crush --version")
  end
end
