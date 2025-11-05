class GeminiCli < Formula
  desc "Interact with Google Gemini AI models from the command-line"
  homepage "https://github.com/google-gemini/gemini-cli"
  url "https://registry.npmjs.org/@google/gemini-cli/-/gemini-cli-0.12.0.tgz"
  sha256 "8eef4daf5bda399ac60fbd163a7e4a1a585fc226f675465e93d63efa1aba08cc"
  license "Apache-2.0"

  livecheck do
    url "https://registry.npmjs.org/@google/gemini-cli/latest"
    strategy :json do |json|
      json["version"]
    end
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "78ec84abf8b7ea001d8fb16595754912c0b5de770977bddfa83bbf3eff9d27a3"
    sha256                               arm64_sequoia: "85b04faf33e35f5e2a672df686d41c812a2cd480d89b449c7089b2ddc6a7c49a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6fc67f9a0c2f2a12f40ae65e1013d79cfdf096aa254b2981a3560f9c74f4eec8"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]

    # Remove incompatible pre-built binaries
    os = OS.kernel_name.downcase
    arch = Hardware::CPU.intel? ? "x64" : Hardware::CPU.arch.to_s
    node_modules = libexec/"lib/node_modules/@google/gemini-cli/node_modules"
    libexec.glob("#{node_modules}/tree-sitter-bash/prebuilds/*")
           .each { |dir| rm_r(dir) if dir.basename.to_s != "#{os}-#{arch}" }
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gemini --version")
    assert_match "Please set an Auth method", shell_output("#{bin}/gemini --prompt Homebrew 2>&1", 1)
  end
end
