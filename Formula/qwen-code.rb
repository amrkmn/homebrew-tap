class QwenCode < Formula
  desc "AI-powered command-line workflow tool for developers"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.0.12.tgz"
  sha256 "439fdd35bc2f7e0cc2cc7a20f927a8184b98319e57049128f3fe4b8629c6b792"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    rebuild 1
    sha256                               arm64_tahoe:   "3955c6c045810a8e08aa8c6f8b0cca1af10e1f694e3acfd4c4ef56ee019815af"
    sha256                               arm64_sequoia: "20988a0dc354e3ec90b6fe89b7e71d4893d609b7174da1e161d1b7d7ad75659e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "66bc13f90fffc7561925a89d5de13e3e7c527a08142f56485e0a94c8663bb24a"
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
