class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.90.0.tgz"
  sha256 "a305af67b2c6cac6f23b82ee5709e1ae6fbbff1d21b6a8da8d35cd4578ca6b6b"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "578f1340782faad88b233faef44b9b52d5885e7ed195cdc4396057dc69614a3c"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "f8ff9c4126ba4ebf7be081b05cf9daeb435bfcd0a4d940ab8ccd1a493a5e4892"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "65bcd9cd5eefb2980bb5e58367828c87a0ee0b2cbbd272ce1578cb9f4445e0a4"
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
