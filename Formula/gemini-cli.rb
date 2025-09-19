class GeminiCli < Formula
  desc "Interact with Google Gemini AI models from the command-line"
  homepage "https://github.com/google-gemini/gemini-cli"
  url "https://registry.npmjs.org/@google/gemini-cli/-/gemini-cli-0.5.4.tgz"
  sha256 "4c272d3be5653bcb31ea9fbd1637c7f3f7e81da91f70b8f3e0072c1c961f57cc"
  license "Apache-2.0"

  livecheck do
    url "https://registry.npmjs.org/@google/gemini-cli/latest"
    strategy :json do |json|
      json["version"]
    end
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    rebuild 1
    sha256                               arm64_tahoe:   "4f96ace96181d20121c57d079a40362c96de253b1ca8a622d3a9bbb5bdeeb8b5"
    sha256                               arm64_sequoia: "bba4d1e4f41ac633b52d57abe65695455cf734b85c0030d488c97dd0568de6a1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b0a9031fbf77fe9da57a7c31ff4872f0f1ec0876eddd7a52886ea5da090d9e87"
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
