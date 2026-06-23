class QwenCode < Formula
  desc "AI-powered command-line workflow tool for developers"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.19.1.tgz"
  sha256 "7246af967e75719d08721c636102f5121f9a1b35444ebfb8264c1dd341dd0180"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any,                 arm64_tahoe:  "ef2bbee4a6fbbcf538bf1df2fc39195e07ac3495053b3979981bce4616d7cbd3"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "984048a8a124ba13ade03833167b6bb46b534ea0f0e989939474439e3a584ac8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ef12d086f6a34f4a228421fc1e0e8c7e17c9f4d0c15372572689e08438354151"
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
