class QwenCode < Formula
  desc "AI-powered command-line workflow tool for developers"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.29.0.tgz"
  sha256 "c4c453267d95929a8ebf684dc1648ea6f7baf104ed5acd3108503115a0a9663e"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    manifest_sha256 "3ae4952f52ac4e0b157e401538d0a7358ad1777e2fcceda849351c270013ab01"
    sha256               arm64_tahoe:  "7b08df018e2643dce5c86dae01fab8d1484ae05898802f0df4f05dba5e18ac04"
    sha256 cellar: :any, arm64_linux:  "5d5521be65a479108882ebade7504ae25a48b5cee146413d0a37e2bf152a5060"
    sha256 cellar: :any, x86_64_linux: "880fa20bed14e1ee2f1438416651571d1a62fd6f1896e8ae8073a43756dd90e3"
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
