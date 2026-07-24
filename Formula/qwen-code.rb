class QwenCode < Formula
  desc "AI-powered command-line workflow tool for developers"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.21.0.tgz"
  sha256 "62fa5ea404a8d1f694edc54446bbd4ca6d3a69e090ec5975977ff51918d2aeca"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any,                 arm64_tahoe:  "639f59635886eb322e8faa596378820aeee3531ea132445fafe59fcd9b5d32d6"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "cd543f8cb25299a02a9346d254d2456bea9c239485b5cc2f6c241c93d578df88"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c47e5e24be39baa4458dd8a0a9511c9f9e8f5aa079cb8b6244c93e9b63bd12d1"
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
