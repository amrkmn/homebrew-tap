class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.92.0.tgz"
  sha256 "e856fb25a1f50505d2b6b9730b0f2c1d63773e41a6c71de7ebaf45671e684335"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "fe5bfa8acf4c8f04c0320eba46441f0ccbd47b9b7caea5fa2024de728c8cbff1"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "8d3b454c89c22681b32c25eb679519f91389763d75fc6c9a9b96480cb7917316"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "cbdbdf7a5173de4b84029a37e37ece46bbc221e70b56a1c3409bfbd3874356a1"
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
