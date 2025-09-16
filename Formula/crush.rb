class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.8.2.tgz"
  sha256 "723440e58ed2ebeeb47eee8e31f490b23fb553e32d98164ec182dc12de77e7e8"
  license "FSL-1.1-MIT"

  depends_on :linux
  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "crush version v#{version}", shell_output("#{bin}/crush --version")
  end
end
