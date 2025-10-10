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
    sha256                               arm64_tahoe:   "1ee12a47fdb25ddd523fec5b8ae8b5fc19d05cc67149a82b4ef9e9e53c0f943e"
    sha256                               arm64_sequoia: "99f2455da31373fb5e52ae7f15859a0df2d0ac570bbffecebc388fda32e7a5e1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "65a85a56f5d1ae17540e09e0f098c8e20da35c98ef44d90e2eeeba8bab5d0ca8"
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
