class GeminiCli < Formula
  desc "Interact with Google Gemini AI models from the command-line"
  homepage "https://github.com/google-gemini/gemini-cli"
  url "https://registry.npmjs.org/@google/gemini-cli/-/gemini-cli-0.5.5.tgz"
  sha256 "9d55b51440e997096616e4c9e295665edc900583f1c762a122ffb872e759c06d"
  license "Apache-2.0"

  livecheck do
    url "https://registry.npmjs.org/@google/gemini-cli/latest"
    strategy :json do |json|
      json["version"]
    end
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "b5165137590a97e80c92693b72e1a3e679f333f65bf810a0545ff9b6f41060b2"
    sha256                               arm64_sequoia: "19a9436a0f08bf04fa46ece31b315182eba2a6d8385b98a9a0f28a86101619d9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "275c35c7ff6d1f4a0359370b52dfd79f88627b531c5795baee517f61fca402bf"
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
