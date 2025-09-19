class QwenCode < Formula
  desc "AI-powered command-line workflow tool for developers"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.0.12-nightly.2.tgz"
  version "0.0.12-nightly.2"
  sha256 "c857f849b863c3fe9a4fb3548436beb4e885334cacc2890b91bac9641cad3826"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "724e7d9788fd86cad2522384392314004c86783e122d9221d1a3e9344db8fe54"
    sha256                               arm64_sequoia: "66a284cddf9e28f2c336b3a763b45921a6075744b9339b9eeb94afa776d2a5e3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1d383ae5f6640ef341381dab602faff21c25a4cb3699b089eddd70c182c9c107"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/qwen --version")
    assert_match "No MCP servers configured.", shell_output("#{bin}/qwen mcp list")
  end
end
