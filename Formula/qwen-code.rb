class QwenCode < Formula
  desc "AI-powered command-line workflow tool for developers"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.19.6.tgz"
  sha256 "fd04f660b7552841eb08dba567df4ca76ca9c269cca40cf78f96798d3751403c"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any,                 arm64_tahoe:  "3c0738336b2c635467947a605743db02417ff98d6c4005296fa88830f60c8ea4"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "ab3f79c5f8ec60119c7657bff633559d85452f30b2547d7c043396d4576a1bdf"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "831cbfe404b1988cc6ab7bfe0fd74ecb0515ddfaea3f01f874f9c1d3ee7e2f12"
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
