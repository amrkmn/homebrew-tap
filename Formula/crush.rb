class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.98.1.tgz"
  sha256 "6ddd7163a490c3262fb939b15eaa2e1bbf551957a4f1f5ea40a5cb6f1ade17be"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "25e16ccea66986385ce20a2e673539e3961cb569824a93d137cd883bebc78d13"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "f711d1d2d7c06d606ef43d9c17ec5b69759bf7c7dc1c6723293ca5fa28f60eb2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8e432918dc01a9f44f4d23f76c5e31818998193302bde3344776e350684fa745"
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
