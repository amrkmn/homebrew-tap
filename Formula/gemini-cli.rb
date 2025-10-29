class GeminiCli < Formula
  desc "Interact with Google Gemini AI models from the command-line"
  homepage "https://github.com/google-gemini/gemini-cli"
  url "https://registry.npmjs.org/@google/gemini-cli/-/gemini-cli-0.11.0.tgz"
  sha256 "c08a26486a0b8b766c0046047f5ea69236dd9bef9202bd528f31a6c1663967b9"
  license "Apache-2.0"

  livecheck do
    url "https://registry.npmjs.org/@google/gemini-cli/latest"
    strategy :json do |json|
      json["version"]
    end
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "23a336d62ab379af73602b43c58e53ba5234ba8072050050a870d3ef68a1fb1b"
    sha256                               arm64_sequoia: "d2ffbf9e71f2b1be55cca2b256969fb1df5d5e3edd9fc3a017c51ef9f363564d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b4458d46eac6043aa18cc0bdb1e521afa8f168ad143708d5022e718db8550fb5"
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
