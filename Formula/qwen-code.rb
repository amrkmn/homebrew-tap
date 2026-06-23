class QwenCode < Formula
  desc "AI-powered command-line workflow tool for developers"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.19.1.tgz"
  sha256 "7246af967e75719d08721c636102f5121f9a1b35444ebfb8264c1dd341dd0180"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any,                 arm64_tahoe:  "c12b516dc2ee1bfae44d263b47f0a76bbecb7a9daf6ba79e0800405192c75c78"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "3ce56cc630524b28c24a6e95a35513bf72fe59ce79aae3c4e12604a6d3ca526f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7ab66578a273a1cac7e8963856d6e25e523c1f15a7c3a751a7ff21b24c1557c4"
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
