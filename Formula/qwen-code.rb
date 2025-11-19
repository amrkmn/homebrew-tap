class QwenCode < Formula
  desc "AI-powered command-line workflow tool for developers"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.2.2.tgz"
  sha256 "a8adb6ee39c1031057230761af2f8767bd2e2d366834931afba925967797bbe1"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    rebuild 1
    sha256                               arm64_tahoe:   "cf57f10c4a7db20b2c59fb50b41042f8d9d36733daacac24415d7bb55becf65e"
    sha256                               arm64_sequoia: "c95183c4e955222e10910cfab13fbcf7ad6f3937da2584da2f82b26c59548f8e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "009243f6a8316f28d2c91b468a21abbb4eabd2087352ecea313c7bb52b144e0c"
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
