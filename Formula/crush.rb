class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.78.0.tgz"
  sha256 "a45883d1d3ae622def10c400448119dfc900ca36e663d7b090ab992d0fd17130"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "954cd2207f5e8285543db850fcfb2cdc2b2bdf6b4fdf678920982aabbb7a0937"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "2f5672c0ae017125a0c4b2b865cd586c81d0728fedd57dcb886c7206f44b1ead"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ca01219d94b9cac3e92e22e9cec4fe61229c34a34cbf42969fac219577b00d67"
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
