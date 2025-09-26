class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.11.9.tgz"
  sha256 "0313d65aae011f90349561e29424dfca77071ac481aed1991c0a6b8cc9762c82"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "e11714cbd3080c6a1f95a547a45d5581716b846864c4dcb82968fbb54c0619b4"
    sha256                               arm64_sequoia: "b537b1786504883f6a0f332eb01b8add698bf257140f0ea3169fc30033a0b944"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "16d13ec0a9443f0cddeac98aba34612c16f84d8e6431f1e4c9cf823224f99be3"
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
