class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.15.23.tgz"
  sha256 "19dd6869cc2b233949e2574d641f9bd5d4595c1f9952212f7a8f8f576caa867e"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "2f0d9361d858d3306480a5325466be9c724395981ad19427b6cfd77ddfff690d"
    sha256                               arm64_sequoia: "ccfc8c3454041ddbce688a1f1cd0bf58f15f2aa4e8c218c649eee069ff9440fb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9a1aa0fc385f80cbb17b136c3df317be7a061234eaa3404b02253ac315b4982e"
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
