class QwenCode < Formula
  desc "AI-powered command-line workflow tool for developers"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.23.0.tgz"
  sha256 "1ca5d9816557f2fea58570aab5c9638fb6252b77abad6a36245dd7eced413e27"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any, arm64_tahoe:  "26d4ad539c617028e52254ae8a010363bae5a2d8ebdc4f5b5f11af43a5a7458a"
    sha256 cellar: :any, arm64_linux:  "71849dab5edde4b1bbdb0280f6a65e1030db482e5d7aa42dc3e354961cc18e05"
    sha256 cellar: :any, x86_64_linux: "fb244cd71f137a0d200227c070bf7945f12a486f0449ba6d7cb3719239f6280f"
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
