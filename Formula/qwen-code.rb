class QwenCode < Formula
  desc "AI-powered command-line workflow tool for developers"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.2.0.tgz"
  sha256 "e56af14622098347192b06a8bfedf04f0b6072dfcb9768934af866b56ae120d0"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "345432c722efa5e4f682388764dbb08633a5e866e1d05255c1f7f2cfb37900f4"
    sha256                               arm64_sequoia: "e28432e77027bf2e707f51a5caa6e7238d9b7e2e4b3d03eae5fbd135b4454892"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f303696bc5fbaeb004e28268d5c92c6037c4cdd4c06c89c6a448bc2b665cf82d"
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
