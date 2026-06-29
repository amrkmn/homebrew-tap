class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.81.0.tgz"
  sha256 "ae3a557ac6803c1e2f8d073eb25e6233329d26460647ff95840cb9fd63c73d8a"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "c351d67d8f1431da4b9b4e74af695dc29c72f1681be7f2c67048a36db0e0482e"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "8f7d5401611fac10692fe5eede3fe1ee63291e204078792993d06cc59526eacb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "439cb1e1198424b66f52bbe2e74e9a3a6c802ea7dff63fc641d2a96e2ef5a3fa"
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
