class QwenCode < Formula
  desc "AI-powered command-line workflow tool for developers"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.18.1.tgz"
  sha256 "e9688d330896ae60fcc70b516fc8af0ea557bf062d298a72664f6e46c8161ac8"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any,                 arm64_tahoe:  "72d2ab59a65dd729eabfb393dded0a277e23c81e5452576693142c2ba49cca54"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "df23af277de8d4c229df5a5c502c9c77055213365d28949e008aedcec0e55372"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ee63bb4e45e2e2ad753eaee51b408e98d681b02f8eb2174fe76d7bb9ddb6ece3"
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
