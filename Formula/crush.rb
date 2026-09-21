class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.96.0.tgz"
  sha256 "eed3eb9ecd5172e271b41b0059022a475e586ceb48f6fea0148b45980f2acd06"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "f317fa8a3d665dc1cf53688bfca12b5ccf1832253770c79ede7eea55165caaaa"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "c40ab59757addc208a8e55e2eab533c5b6bbc0daa21ed3c64159f2422c962bcd"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "95c1c933b10e6be887219ae08640a7fce09ea6ed02c5913aede433c9d2dd595f"
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
