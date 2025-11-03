class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.17.tgz"
  sha256 "dea853095f0d40758c1f2f1554d2e67212a793cc164371e9f86730b57c974dd4"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "a0bf09e56551e3cbf04dddee4b030fc56c8434de9618bfb9225e072b7b0e9530"
    sha256                               arm64_sequoia: "da13f8486cf21b61f5ce2b90ef8796ce64c3dec414fd5c914892c80f1af8d6d6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a0349dd3c86f91418dcafeacf3989f730f853fba0aefa6aed4e72e6411580e35"
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
