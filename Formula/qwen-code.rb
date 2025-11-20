class QwenCode < Formula
  desc "AI-powered command-line workflow tool for developers"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.2.3.tgz"
  sha256 "9c6d1d3771043d6e1df7f2b072d629066f07021db18113cafa455e438723e032"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "8efb593d51e8e266b0b92983956676b5de83e178f107f159c1b266b347f86d06"
    sha256                               arm64_sequoia: "b17e058498fa254a99b7ef95b4ad264139c1b8da22d43bae02ec039465a32fc9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b915afbd4e9095894311f204a1d767381c9b87592e036bc6a48669e846e2a923"
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
