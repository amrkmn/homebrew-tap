class QwenCode < Formula
  desc "AI-powered command-line workflow tool for developers"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.26.6.tgz"
  sha256 "6d6889ae71ce6f3a892d597ba731edf1a45f34f3443ba1e55080511d1794b9cb"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256               arm64_tahoe:  "5ddb446cf17ab60ed8a30bc3adc1ddcd952107553d1d909cd7c887a6164722cf"
    sha256 cellar: :any, arm64_linux:  "e3f4c25194d65e13e678d0997325025bf8d012fdbfb77b75181fcf9cc3a37264"
    sha256 cellar: :any, x86_64_linux: "b273dd2969f3ec73f1ac8f514e0dafd3a2274aee6c5d20f538a7f142f3705495"
  end

  depends_on "node"
  depends_on "ripgrep"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")

    qwen_code = libexec/"lib/node_modules/@qwen-code/qwen-code"

    # Remove incompatible pre-built binaries
    rm_r(qwen_code/"vendor/ripgrep")
    rm_r(qwen_code/"opentui-assets") if (qwen_code/"opentui-assets").exist?

    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.intel? ? "x64" : "arm64"
    (qwen_code/"node_modules/node-pty/prebuilds").glob("*").each do |dir|
      rm_r(dir) if dir.basename.to_s != "#{os}-#{arch}"
    end

    qwen_code.glob("node_modules/@qwen-code/audio-capture/prebuilds/*").each do |dir|
      rm_r(dir) if dir.basename.to_s != "#{os}-#{arch}"
    end

    (qwen_code/"vendor/landlock-run").glob("*").each do |dir|
      rm_r(dir) if dir.basename.to_s != "#{arch}-#{os}"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/qwen --version")
    assert_match "No MCP servers configured.", shell_output("#{bin}/qwen mcp list")
  end
end
