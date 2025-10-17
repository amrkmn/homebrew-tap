class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.15.7.tgz"
  sha256 "652d0550cd662c1770283c9b9e93ab4c01cd9895d8bcc9b7b4533f9da4ade241"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "4ea90b2741786b59399aa20a931c832a0e68aa05186a9bcdf3c774b6989944bd"
    sha256                               arm64_sequoia: "b277265a430e2a36419ca84b2b60f2f89e4b19bfb3180a58de36f531698f8d4c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0d0339f870460e5faf5303c1ba19c77042f8f23aa45188175346aa88806be2f9"
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
