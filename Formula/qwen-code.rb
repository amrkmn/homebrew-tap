class QwenCode < Formula
  desc "AI-powered command-line workflow tool for developers"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.27.1.tgz"
  sha256 "c4b2f0f92f7076456c45bc22d714000c6f240a85a2ab6e55ded806696f05581a"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256               arm64_tahoe:  "3783584918a5ff8e9f84542d73b1d79b4fb016fd45d10845a73f1635eb4df6cd"
    sha256 cellar: :any, arm64_linux:  "23429af078838029fbebc7c8f504eb897261caebe425e51da012a4980ef62dd3"
    sha256 cellar: :any, x86_64_linux: "05f0c268916a5db49005e3c6c65acf0025917a823e436d9203b75333aa09be08"
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
