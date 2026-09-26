class QwenCode < Formula
  desc "AI-powered command-line workflow tool for developers"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.24.6.tgz"
  sha256 "9f0e7ba70009cc0a5133208cf8edc21f26eef211e9d14d0d3f497cd42a9e31f2"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any, arm64_tahoe:  "b08299fee9de1cda11d43fa88acb1f3835c2b0b0309605ce0abd3bd6f8e14d22"
    sha256 cellar: :any, arm64_linux:  "181c8b0111a12cde0e4309407e9bf8738b21941ca54b7c96a95d65eaeaab5fba"
    sha256 cellar: :any, x86_64_linux: "4e97f81b9711579ed08d48fcbd705eaf1180d4b96bc80f5e6f53556529d8cbb7"
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
