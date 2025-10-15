class GeminiCli < Formula
  desc "Interact with Google Gemini AI models from the command-line"
  homepage "https://github.com/google-gemini/gemini-cli"
  url "https://registry.npmjs.org/@google/gemini-cli/-/gemini-cli-0.9.0.tgz"
  sha256 "75a632e7501a7450a2784eaef9afb22bb0d3e1960a38cd61a33fdb56f9c44399"
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
