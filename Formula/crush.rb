class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.78.0.tgz"
  sha256 "a45883d1d3ae622def10c400448119dfc900ca36e663d7b090ab992d0fd17130"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "646eec2ea517650f3853113edb37d39ac238b43b685d010e5ece30dc56c9175a"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "27651d7336e714b8180d550b8ff9cb0e5ef2777da139e4ff5ab5c93887041fbb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "067c94c964b773a970fee9823d0c7848f1d131c55496115e65d3434f66fdec6d"
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
