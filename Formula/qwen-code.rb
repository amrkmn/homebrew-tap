class QwenCode < Formula
  desc "AI-powered command-line workflow tool for developers"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.0.13.tgz"
  sha256 "d7347db0b25c42b621517ceb305a1c01320a38cc9eb4e9d790ab5da0df5a7581"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "4cfd7daa9d0132d79b14f14e688fbe4bd96b1d66f1912a6a423b874726311284"
    sha256                               arm64_sequoia: "9a0aebbfd64b1636a710142e7208c9522b67690b5e7642b077bf26652a8d5b83"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1be9fc4d3a77ebf0870f98ec88d35fd4001d2ecc832ee680eb747ea332b1a5b6"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/qwen --version")
    assert_match "No MCP servers configured.", shell_output("#{bin}/qwen mcp list")
  end
end
