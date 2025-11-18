class GeminiCli < Formula
  desc "Interact with Google Gemini AI models from the command-line"
  homepage "https://github.com/google-gemini/gemini-cli"
  url "https://registry.npmjs.org/@google/gemini-cli/-/gemini-cli-0.16.0.tgz"
  sha256 "e308f29581b66784bc550273e6f71640df50d88be42b02c986770abefc54be3c"
  license "Apache-2.0"

  livecheck do
    url "https://registry.npmjs.org/@google/gemini-cli/latest"
    strategy :json do |json|
      json["version"]
    end
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "e40ccb0d6963dd34ad788c0decd8d88857aac6fecd2c066592c51fb7902d8974"
    sha256                               arm64_sequoia: "1be88e53e001349a3030969539346b0d839ba91fb42b3606cd1c64282853b4f8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e10d58edbdef2c767220a9f6c60f3b2af66d1523b947b985a01c20f461362546"
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
