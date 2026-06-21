class QwenCode < Formula
  desc "AI-powered command-line workflow tool for developers"
  homepage "https://github.com/QwenLM/qwen-code"
  url "https://registry.npmjs.org/@qwen-code/qwen-code/-/qwen-code-0.18.5.tgz"
  sha256 "661c6328f9616bd81f8b310f9c30dbd9198ddf19155427d4af90413021f56436"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any,                 arm64_tahoe:  "a1d510d7c6dc3fd5b81c11b4def794eac464755e5826f6af76979d583c820cf9"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "09c11ef5181539e91c82b62f285cf539f800399a8817cb395d3479634e40e377"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "404a7bf2608f609e1d5bc6d2985a15584af8cc5bc64ec20f32c382449c6b49af"
  end

  depends_on "node"
  depends_on "ripgrep"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]

    # Remove incompatible pre-built binaries
    rm_r(libexec/"lib/node_modules/@qwen-code/qwen-code/vendor/ripgrep")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/qwen --version")
    assert_match "No MCP servers configured.", shell_output("#{bin}/qwen mcp list")
  end
end
