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
    sha256                               arm64_tahoe:   "b7480898af6d1be900f8a74a4959a5da38edee5a764ad7ba7eeda17f53bbc3d0"
    sha256                               arm64_sequoia: "11f9c788bc3c983ee9eab5e49b958de8fa348a5b35f905a7a95bf6640200da82"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "37c7b5fbb5b15bd3b21272d40b055aec874ccfb54323f8f6e9d24adf37efac42"
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
