class QwenCode < Formula
  desc "AI-powered command-line workflow tool for developers"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.1.0.tgz"
  sha256 "81ccd19d0904d66aea4d61ea9f04ac20d2ecc91383ed9c9ebaeb2b314aeeb027"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "f2e0d278babe080f803ec178373791ef12300ff6eee0a9c53c6b913c31275729"
    sha256                               arm64_sequoia: "01cfe666a82c20ff5f3c882f213f7582c04cb884db8880cdb00aa9797a33d665"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "97ce68db2f9cef521f21ac8b027a18857eed8dacc2a981f7ef67b74067b5c1c5"
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
