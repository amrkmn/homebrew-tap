class QwenCode < Formula
  desc "AI-powered command-line workflow tool for developers"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.18.3.tgz"
  sha256 "41ca0ee791130e04e984b6e1cefef170a73f3c10bfb0c42444f4ba0b68cf5e20"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any,                 arm64_tahoe:  "fa40e9e914bdedc5a7ddce452c9082344756b381b5b9e6d287074387eae6e73c"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "d80b04c02021b5ab6053a6284002ae7d5caadb05bd6a04a3ede6a197cd53809e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "aaa91a83135be25f9d5c2c0bf8bc4594f47a55c9a74547aa9a3ae7f869076fed"
  end

  depends_on "node"
  depends_on "ripgrep"

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
