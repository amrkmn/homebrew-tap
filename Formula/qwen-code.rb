class QwenCode < Formula
  desc "AI-powered command-line workflow tool for developers"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.0.12.tgz"
  sha256 "439fdd35bc2f7e0cc2cc7a20f927a8184b98319e57049128f3fe4b8629c6b792"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    rebuild 2
    sha256                               arm64_tahoe:   "50d29ce91d888fb0fc90d0e21fe9d3e72e41713efc55b0e55922b9ece94c5fd4"
    sha256                               arm64_sequoia: "a48a249d7ab271fb10344f3c7636a9c17cec8a15e2fc92d47bb636277d03c198"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "93ca06c13f21e279cb8809a028ad5bcf7829e0f2330613207f19344db15c3de4"
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
