class QwenCode < Formula
  desc "AI-powered command-line workflow tool for developers"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.28.7.tgz"
  sha256 "3bd80542c3660fcc07f9c987aad7dedc89b8564321583d17bf8d5438d536a6f6"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    manifest_sha256 "1f8f06890902d619584f306eced25be1c5411c9775187f648abbf3f76a5a3042"
    sha256               arm64_tahoe:  "b8044a5e6e9be7622cd1d60b0c5fe5756ee21790108e313df831a5ddbb01ea79"
    sha256 cellar: :any, arm64_linux:  "1b6fc01c5dcf3c6bca146546021f82373a7cb37fbf96c6aed2246b9f161f19bd"
    sha256 cellar: :any, x86_64_linux: "3ec2d57773a78dd0c3a747b4aeb8a9f59a6919c92b1901dd4a1538062c5749dc"
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
