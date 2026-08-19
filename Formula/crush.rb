class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.90.0.tgz"
  sha256 "a305af67b2c6cac6f23b82ee5709e1ae6fbbff1d21b6a8da8d35cd4578ca6b6b"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "37e97cc1a65e4a455e08d1d3342c434e10650fd56c5c804d52782feef22989f9"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "8633c11d70f2b2caff0310fc2cd3fb5add51b14ecf6ba7fe9f949e7c0818a58f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "99c953a83d69ad674c43cf1becc1be098523b412b12fec2fc9640726f9ac879b"
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
