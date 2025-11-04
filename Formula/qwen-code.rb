class QwenCode < Formula
  desc "AI-powered command-line workflow tool for developers"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.1.3.tgz"
  sha256 "4b71cc73166fc1f686cfce7a2060679da3bed27261d20b1be9784ad117e3880e"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "1ca392928c8153e72416ca99a72fce9225e520a1d66d79a3a860cb62fb0d05ef"
    sha256                               arm64_sequoia: "2661c319691a6702ea7b3e745e4fe9e440e882145e77882a472cc48e09f24112"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5c1beef10452376dc838ed940423ce35d52389310ffea2d06d34fff884901051"
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
