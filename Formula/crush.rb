class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.100.0.tgz"
  sha256 "20967488a90191e678294f442e9b511c58008dec22709d8d787a600c53e56f07"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "30814a3b4cbb271e92ef08ffc25abeb5e161d1ce2fd3f9252083805502141e42"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "48c33c260e4d3c5c47423c019b948b71101e4c76ec9575c1ef898bc8201a6c2a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d0ad498eb555d6d4981cbf7d2571cbbe51d125b1303c8fc57ec869f7324a3377"
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
