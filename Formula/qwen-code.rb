class QwenCode < Formula
  desc "AI-powered command-line workflow tool for developers"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.28.0.tgz"
  sha256 "32ca2695069210bae82410a8712d8658a7da5779ecbfcd67160adce415a4e1d9"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256               arm64_tahoe:  "f10c77b7dfb0968b7e2715f8e81a7c92d75084ecce4513a849cf8faa22e1446b"
    sha256 cellar: :any, arm64_linux:  "64c3622ff214a49026f8e82ba51fe6eb7462d81492c085892cabc07f5c40fc25"
    sha256 cellar: :any, x86_64_linux: "2cd814138f5ba808f42faa5016c6d442115f695d183122a43441b5caecfeaf9b"
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
