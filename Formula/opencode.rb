class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.18.tgz"
  sha256 "aa94f4d65112886e250cf8e799f48fec6ba13ca728db46bf9fbc1ffa7f4d5640"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "2deedd46d468c397c0440ea24d8c6787bb7f57d12ab14205e634a9ca66812f8a"
    sha256                               arm64_sequoia: "020e65a36d2daebb9401eae1b4f30bed2c15e93b6a0c8a8fbadca3ec67afaa0e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "126fd394637788abfaee91b85464b0a0eb8110e9929185642a5cb4fde341bee8"
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
