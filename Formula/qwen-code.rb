class QwenCode < Formula
  desc "AI-powered command-line workflow tool for developers"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.19.11.tgz"
  sha256 "29a6d8d1150a734c10c737f4d67c7af806493c6408d3cf44d62e47d64fecc3de"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any,                 arm64_tahoe:  "53cdaa43262a04351b659d173d25e44158ff8164a4de6f6b551f48449bf7d456"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "bdbefec6eb48aaf75e646af095588b88f9a2613e29b253be46452e28f358b013"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2a3bbfcdd103fc8bd61d2212e31dde4bfa2e123ece3f5722202aeaa88c6be7ce"
  end

  depends_on "node"
  depends_on "ripgrep"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")

    qwen_code = libexec/"lib/node_modules/@qwen-code/qwen-code"

    # Remove incompatible pre-built binaries
    rm_r(qwen_code/"vendor/ripgrep")

    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.intel? ? "x64" : "arm64"
    (qwen_code/"node_modules/node-pty/prebuilds").glob("*").each do |dir|
      rm_r(dir) if dir.basename.to_s != "#{os}-#{arch}"
    end

    qwen_code.glob("node_modules/@qwen-code/audio-capture/prebuilds/*").each do |dir|
      rm_r(dir) if dir.basename.to_s != "#{os}-#{arch}"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/qwen --version")
    assert_match "No MCP servers configured.", shell_output("#{bin}/qwen mcp list")
  end
end
