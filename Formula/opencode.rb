class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.14.5.tgz"
  sha256 "2e841be1821ccd2f8c18a5792da6f823ee0d6041ea95815ab11bc2a1f3817174"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "37be5431fb97637f0efb3a1c54d00ed98434d99fac67c2f7bf07a9a97f003dc4"
    sha256                               arm64_sequoia: "2b1d56895424fe79ae3a5678e0c21a6fceac71d50f497db2c480f5b2ddebf6e4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "609e8a0e5233086baa01ff7317214aba287a0fba7b34de60dbf5d2aa061af5e8"
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
