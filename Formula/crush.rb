class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.12.3.tgz"
  sha256 "942e9dac82329f022ad1935adb7ea5ceb07aca1b8ea9bdfa141ff6f4e46b69fa"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "04549e90489f517a276dbc02a29058b5b22654739ad54d6596fee38dc5cb6450"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "312ac2513b979f5e12579f9ecae167ac54ae71d9f57f6d229e861393c310a457"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7f40f00554fb86aa25a3cd95d831ee4f54c5248671ab919391334ced5b77a992"
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
