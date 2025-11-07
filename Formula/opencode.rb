class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.41.tgz"
  sha256 "a2d4926a4764a2c737ca0f74692be41ad89b7b87b54efea88fe9410b2236955e"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "38f8eec93dc01b2b9513adea2e8f41ef53e3752423a24d9cd5ead3078038a60f"
    sha256                               arm64_sequoia: "05b30d9e7f0e772a873338017952ab08577913b7e6184f82df7cf47890355732"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cd0a9b4db3c8b30c62712cef3deef0366c7daadbe99243d1d632e0d12eb2a47c"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/opencode --version")
    assert_match "opencode", shell_output("#{bin}/opencode models")
  end
end
