class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.13.4.tgz"
  sha256 "864a84b34ddef1efefcd1a6046c6c25680a697c5342a42949777c4b57096fc2a"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "3afb01932512cfac5edde5184ea7c8938b0bf033e53de54f67522314c6edd2fa"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "791884dc367261f7cde6887d23c8fca987c56cac917c055031331c006d9d6be5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "00c82669a21a714091ae3620baa95769c851c70ea232f04eefab87712b10e6f0"
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
