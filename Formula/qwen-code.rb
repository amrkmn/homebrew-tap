class QwenCode < Formula
  desc "AI-powered command-line workflow tool for developers"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.1.4.tgz"
  sha256 "2c2c98d889ec4af75f5476fa17dc1f269bc3ba31abdd8d07db4b31d7378e0985"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "21e709bc0e1608cc2d4dc288447b886db14216331cc5fd889782786c2d8ef4d0"
    sha256                               arm64_sequoia: "213fc2c98f169da394a50db421d237e1b5e475d6a175f298512d41e0b6ba89ea"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3b044feedc20ee9540e98a5abd7f7b6a5949792f65c2bf3f2ef3387c6bb26365"
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
