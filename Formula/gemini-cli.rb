class GeminiCli < Formula
  desc "Interact with Google Gemini AI models from the command-line"
  homepage "https://github.com/google-gemini/gemini-cli"
  url "https://registry.npmjs.org/@google/gemini-cli/-/gemini-cli-0.6.1.tgz"
  sha256 "f94382e12d7af7bb3cad0c2f64445c3ef569bf08be540796d8d7ce87f2bd727a"
  license "Apache-2.0"

  livecheck do
    url "https://registry.npmjs.org/@google/gemini-cli/latest"
    strategy :json do |json|
      json["version"]
    end
  end

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "25c2efc8e75915a6e0570f9df10de07e0096931bb183cd1ef8680d39ee5d3947"
    sha256                               arm64_sequoia: "dab3bea5fd2bffda92ca71a1d9f5e272e9583d7defdd1449155f021180c5b022"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "743a0417a03d659f4254f8e96fd254d83371aaffe3e1c50b4f3091afb03d9979"
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
