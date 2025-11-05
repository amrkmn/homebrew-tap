class QwenCode < Formula
  desc "AI-powered command-line workflow tool for developers"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.1.4.tgz"
  sha256 "2c2c98d889ec4af75f5476fa17dc1f269bc3ba31abdd8d07db4b31d7378e0985"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "96129fc747da0ac01a7c901c5fe68e319d35ec0851e5bdcd4e0d0f643aef5cc0"
    sha256                               arm64_sequoia: "36ea784ad3c97fea7d7a848ced68ddf27be541cb4589a15215e8fc6362f0c3f9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f5f62f012ec65a75e655a28875587f20ae56ed1064bcd2f2d77d4aadcc6d26df"
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
