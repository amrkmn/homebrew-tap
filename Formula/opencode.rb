class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.15.23.tgz"
  sha256 "19dd6869cc2b233949e2574d641f9bd5d4595c1f9952212f7a8f8f576caa867e"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "d50658a332edac4f09e21ec82b5ce517bd38b75ad275fae4f3e9b733c16e42fe"
    sha256                               arm64_sequoia: "182fc4764d317adbf7df6767cdafb0fee2e22afc217e0804389bb2c625b0a386"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "dd5ce9f9418ff5251a8af284c6826de06be875e906ee07fe3e40229ac57999e1"
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
