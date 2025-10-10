class GeminiCli < Formula
  desc "Interact with Google Gemini AI models from the command-line"
  homepage "https://github.com/google-gemini/gemini-cli"
  url "https://registry.npmjs.org/@google/gemini-cli/-/gemini-cli-0.8.2.tgz"
  sha256 "9c86133427622e63a73ba564f27a80fcd40a3ecbc3ef919acd6b3cb0ecc7c705"
  license "Apache-2.0"

  livecheck do
    url "https://registry.npmjs.org/@google/gemini-cli/latest"
    strategy :json do |json|
      json["version"]
    end
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "8cbb3557250fa649750d46a68380ca7ae77bc6005b2b080c44a0a996c017131f"
    sha256                               arm64_sequoia: "d163953c960a61954939e1bcecdd8aaa43a8c690fafeaed886695f477cc5b18b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7b822f98f36ac949fb5c32e0bdb015f2f1417c4ceafa32224f09cae65b8e2542"
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
