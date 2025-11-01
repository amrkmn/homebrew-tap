class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.7.tgz"
  sha256 "7d036474ae87d4894fbf3a97c51da2219b191be7f026c5d70027d89d41435a16"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "1b51ee9d45a5f707e9b2643a0635358ace01f0605e9abdd93896f6de2c5e2ba0"
    sha256                               arm64_sequoia: "0a95240ca1c9784f10b5773d87f600106f566dd1d316fd1604c25e402f79746b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "78bf5122d3545dba05f597b68264d69fce23efd4a082af7539eb20a4179401ea"
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
