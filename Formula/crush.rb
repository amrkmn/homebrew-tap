class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.11.2.tgz"
  sha256 "d05074b6cfe7bdb340532dcc4e06efc2be9b7f22c45661eafb4df6819821f772"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "04ebfa279d75626e00fb06c23511f5fd1bbb84257870eddd01c4d3e86b08f2da"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5a0bcc374d019db98149166b6f1637665dba23db07015db6013c8fa13b6114f9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "801ed644421bcd0c942d70769014d78aec425c6a0861626f44e10bc5b801d24e"
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
