class QwenCode < Formula
  desc "AI-powered command-line workflow tool for developers"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.18.4.tgz"
  sha256 "02a6eadeb4d082adb5a6c13378e4e7a12d2d0f6cbaddc568f475a5ef37898fc7"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any,                 arm64_tahoe:  "4bd9b3afbb954a4612dab62f545c06029f619918314d619461ac541c1ae01de2"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "393a0b81987c306f91ca9847f8ac1946c9a22059c434cf80f78f6775328e235a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "61bc2531001cb8591e141adc8ffaeae33d219c8a646e3ec38460702260dad03f"
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
