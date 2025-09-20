class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.10.3.tgz"
  sha256 "250310735f8908b96a2ceb09b92a8206222872a1f63ef9c311774bb7d79351f1"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "3f58e770723a88b6839a3050a940bd9196c7a930f1d2c80577ba6916d2772a49"
    sha256                               arm64_sequoia: "1512e956f9b9c0027e6a5b9c862a7780083a89b2e1595e63dfa5cc9fc7f8d78f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a73cd7cc20f130b6c3328c4dbff42c665fca0f16fe340d41d4cb2ebe1020ff48"
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
