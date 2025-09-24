class GeminiCli < Formula
  desc "Interact with Google Gemini AI models from the command-line"
  homepage "https://github.com/google-gemini/gemini-cli"
  url "https://registry.npmjs.org/@google/gemini-cli/-/gemini-cli-0.6.0.tgz"
  sha256 "3cd5b6f462f0ef108421530e9d9eed92f0d557fb2ff2d6712845b8f0cbbd2c18"
  license "Apache-2.0"

  livecheck do
    url "https://registry.npmjs.org/@google/gemini-cli/latest"
    strategy :json do |json|
      json["version"]
    end
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "b1a1a7e20c76e0a7744d2529bbf3ce2ba409ebdb18b2a2515762972f25f3c1b8"
    sha256                               arm64_sequoia: "2c397c268b44f42c27e7949c616393c93eb58dd66f0b0436490c9ca0e764f054"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "33c8b0e808fdc26835d393c64ddcefc1ab1a3d6844dcc8dc573ac6cce5f8dfe8"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gemini --version")
    assert_match "Please set an Auth method", shell_output("#{bin}/gemini --prompt Homebrew 2>&1", 1)
  end
end
