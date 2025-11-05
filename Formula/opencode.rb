class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.25.tgz"
  sha256 "8f172bd44d613e17087366c48c0e05aeed9f5c20813d9176bdfd1e7695e4130f"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "d621e37916cad554dac7e1db7c4b30a8090f5190a0b580ea1d719ff9a48aa1ff"
    sha256                               arm64_sequoia: "2768cf698419af75e251b875456fa2e439bcf280d1640fcc8480ebf0a3d73020"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d7930631f4e9c59963feb1fc598acf0e917459022ef9dd05475a795803ac6bf4"
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
