class QwenCode < Formula
  desc "AI-powered command-line workflow tool for developers"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.0.14.tgz"
  sha256 "aecde8ce4154ff9d55f459e94e04029ecbf09426dfada0cbe97da71964f12352"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "836360cea119cd7c22c8d590b1c8a56d64279f5b70d13e90d5f019d946373414"
    sha256                               arm64_sequoia: "a9659d5f2326767c9b7d7d5cb03129eda4705eceef3e778bd431a531b5b3023c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "43a6d127ef2018e2e0c8b0bb40e75a613f4c06939e9f7e1cea7287ae0b5e2d00"
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
