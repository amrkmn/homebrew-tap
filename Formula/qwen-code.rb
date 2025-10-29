class QwenCode < Formula
  desc "AI-powered command-line workflow tool for developers"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.1.1.tgz"
  sha256 "885577bfa54ff42e4ea6bd556c62ded0b55f119f1edfca26e8ede0c9f2cc11e2"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "441a38bdbafc672853f7238f09ecc03fb149ec8e4073c733bb68ead0ab05b435"
    sha256                               arm64_sequoia: "1248eaab2c7748d572df5eda79ed001662a2b4d029245b716a7fe85c382a45e6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "62746bed7bb071d4050f4984cab537c3a2d4006774c60e54cd312dfd1b91db8f"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]

    # Remove incompatible pre-built binaries
    rm_r(libexec/"lib/node_modules/@qwen-code/qwen-code/vendor/ripgrep")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/qwen --version")
    assert_match "No MCP servers configured.", shell_output("#{bin}/qwen mcp list")
  end
end
