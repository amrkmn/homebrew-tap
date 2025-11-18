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
    sha256                               arm64_tahoe:   "593537afb412d8597a6e1e990da17d8b14bcc8f6d62b467350911ba3aaf97386"
    sha256                               arm64_sequoia: "cf79f885c5057682a881c39c1f39c920c084c5deda4a7480271d7fd826c5415c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "30e0d82853b253a47e220d7f8484acee66c686e7ebe775f36f9a6e611a3224a4"
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
