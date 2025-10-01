class GeminiCli < Formula
  desc "Interact with Google Gemini AI models from the command-line"
  homepage "https://github.com/google-gemini/gemini-cli"
  url "https://registry.npmjs.org/@google/gemini-cli/-/gemini-cli-0.7.0.tgz"
  sha256 "a9cc6e57d470158b533b564f746f2d7409308870567ef2c9efd9b3a66b916741"
  license "Apache-2.0"

  livecheck do
    url "https://registry.npmjs.org/@google/gemini-cli/latest"
    strategy :json do |json|
      json["version"]
    end
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "00feda768fb710eefb4526bf1a1484c6bf6c37157ff424a95bd691b36963fb91"
    sha256                               arm64_sequoia: "a70378b8aca60aa634c18360e588a23795c235e399adda5d12ac8c478b9f79a1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3c30d73e2b318b4bc8559fa383c9928b579004062d5a46e5fb44427e72db9ee6"
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
