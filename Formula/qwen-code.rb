class QwenCode < Formula
  desc "AI-powered command-line workflow tool for developers"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.21.7.tgz"
  sha256 "9a5c6efa1e8632f8e3243455f553d8749360d97f958750b6666b622ce2cc1d25"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any, arm64_tahoe:  "ea98acde5571b72b78058ef8248de9a357db2ad6d23cd4a7690973e247ef557c"
    sha256 cellar: :any, arm64_linux:  "188ed8483e9fed163e3416663b2b22b534d3bdb347689c49bfa1a5855abb69c1"
    sha256 cellar: :any, x86_64_linux: "0c24d64e2c7b294d69a4964904268270c721bb03db2d08c37975491d121583f9"
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
