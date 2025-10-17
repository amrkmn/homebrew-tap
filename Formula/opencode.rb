class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.15.7.tgz"
  sha256 "652d0550cd662c1770283c9b9e93ab4c01cd9895d8bcc9b7b4533f9da4ade241"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "1d623dd8220461c8808e95d62cb22c6c4b0b741ec57d2ce73d4ce53057489c96"
    sha256                               arm64_sequoia: "39e317ffbeac0e5a24088b51dbb88d604c1cbafe8f9cec6cad79c7952452edbe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ba0496b57a6886cd37a5a96cf727f5d11b37b877f177bf6843014ac054725249"
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
