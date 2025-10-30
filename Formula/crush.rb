class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.13.6.tgz"
  sha256 "eb7150b897dfef70f442757239a529611bbdf7cf3282a698962ce647057d91d0"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "bafae663fe598c9187ae746c5b404d69c3593bc755b49b944b62bf15e9b6822d"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e6c60a0073925c2cd002d51043a5e3880503724d266adccd94837249a59f1d39"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7f2dde2adc4839d1f28d72e160b371018519ee9048d34ba9c8427dc9ff9f8069"
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
