class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.15.tgz"
  sha256 "b4344142b8f3315ce95e884855c560a6c768ba4a20b71132bb722129513a6ce9"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "7ded9bafc3ddec874c53084eca8b4976e8b5dc8d00779e16a2c7092260f7596a"
    sha256                               arm64_sequoia: "7cd8b26dcf7d8afadabb537f5ae65aaada0b189b0717bfd7808a7bef08ee58fb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7e60646f1774b5f62cda7a54e30ec8b70917cf861c7d28abfd030e7d47f49fae"
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
