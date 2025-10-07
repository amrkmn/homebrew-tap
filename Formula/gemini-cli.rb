class GeminiCli < Formula
  desc "Interact with Google Gemini AI models from the command-line"
  homepage "https://github.com/google-gemini/gemini-cli"
  url "https://registry.npmjs.org/@google/gemini-cli/-/gemini-cli-0.8.0.tgz"
  sha256 "b270ce72e33f45dbc2ef99dea50b207cf51137ef02b4e5c578bd943546e6d694"
  license "Apache-2.0"

  livecheck do
    url "https://registry.npmjs.org/@google/gemini-cli/latest"
    strategy :json do |json|
      json["version"]
    end
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "7a9eec6ae21b2641be8def3820fdebeaf592ee2e00ed896ad1ca23cbd55f90ab"
    sha256                               arm64_sequoia: "4234e2ad3f7fa33e1b4175dd090c6505222281c24bd8233e8ef3f58dd7b3fbc4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4c1d55eb1e40d95133a2b8b8006825d258981a6a71e94d740bb87669d82a02e6"
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
