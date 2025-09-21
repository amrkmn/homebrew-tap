class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.10.4.tgz"
  sha256 "00ad049125d1bfa8d995ba839d4223777747121662eb04354cec36f1a101b8d4"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "a01925f70ecc42798731615f65e86a89b5797eee9ef639c99dcb956f7462f81e"
    sha256                               arm64_sequoia: "c81f5446e60ff16dc4e470911525f7cdf200be3a5739b939a7301c7db602c558"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "be910217ae81a677df71b6f39a11c465af750093cb2de9e09afa45fc8c8d7fc4"
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
