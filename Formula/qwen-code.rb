class QwenCode < Formula
  desc "AI-powered command-line workflow tool for developers"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.2.3.tgz"
  sha256 "9c6d1d3771043d6e1df7f2b072d629066f07021db18113cafa455e438723e032"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "84372e61f09b85c19f753f0593e0dc45cb2ba67ac2517da2e7547963c210a44a"
    sha256                               arm64_sequoia: "bf4d728c459d0a98e2665edc29dd02c090a6499bbf186682ec49eb42660cedc9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8c9a1b4f63810a8fd5fc9f375ada741aaeadec7a9a8623154323235fd4fa3898"
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
