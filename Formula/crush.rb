class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.10.3.tgz"
  sha256 "3056c39deff5da25612b8a45df88b565c9f06ad7c26109312c1117e7e256d68e"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "440ad3b3db0d22da05eb84c2209ce58e9c6d89377996acd7e6db9111c6139a14"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7a9a9db4b13f6e3cd8aaf40f6a0dd98c43c5e556f2552a1f4fe2e12832632864"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3f9631634385f20116049475bbc96e00908b6ec11bbb87b597efef482b27d26b"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "crush version v#{version}", shell_output("#{bin}/crush --version")
  end
end
