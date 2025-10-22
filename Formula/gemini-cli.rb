class GeminiCli < Formula
  desc "Interact with Google Gemini AI models from the command-line"
  homepage "https://github.com/google-gemini/gemini-cli"
  url "https://registry.npmjs.org/@google/gemini-cli/-/gemini-cli-0.10.0.tgz"
  sha256 "2dbd623d48c7a51aaf68600b1a541ac9c667ef7263525f44fa701348a0a0e147"
  license "Apache-2.0"

  livecheck do
    url "https://registry.npmjs.org/@google/gemini-cli/latest"
    strategy :json do |json|
      json["version"]
    end
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "ad12cb17659c1fbe7ddb707ce89b032ad2e0dc743f905f1ca9d564ca06118791"
    sha256                               arm64_sequoia: "f5b3da1525b34654c82f7dcf34734c43c527bca35380e08476828e948b889c95"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4842ecd49581454eb6592013a6877faaef0d0fce2ecbf260fb713aeacc6d5959"
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
