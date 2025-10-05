class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.14.3.tgz"
  sha256 "79e22652542054e1db6697279cc058e3b298a1901780f944dd4d95639de20664"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "4162e1a455107e58b40100aa372cbe6c115bb66a6142a4e22e1cedcc750dffc5"
    sha256                               arm64_sequoia: "bf7d00da5ad2e8087dd8af5b9674285e269168204ce74aab633cff7f0fe33b7e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "01308e18415d45b2bb1be88380055e31af2db54f1bb094191c8d842f73546c38"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/opencode --version")
    assert_match "opencode", shell_output("#{bin}/opencode models")
  end
end
