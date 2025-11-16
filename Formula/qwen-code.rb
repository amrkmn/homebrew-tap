class QwenCode < Formula
  desc "AI-powered command-line workflow tool for developers"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.2.1.tgz"
  sha256 "1ad1015a788198236ac04ea64784acf15191c195760a840817a140e2337380cd"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "91d3f31c47a0189980371cdf4a943b6f92c6b860c6b03faddfd445c87de8ff18"
    sha256                               arm64_sequoia: "77e28f3687332d86899dd4eb9e69583e9d29250a7b357f2d8fb3e052dd10ccdc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "002ddb82f99c3fe5ed8c3c85c1c7346ebfd8298def24450aaafece9a1b56edb2"
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
