class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.15.24.tgz"
  sha256 "3fe17ca8b9b5a31458c1ae1581650d98ecfafd977584240d68fdeb576d378b95"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "1c883f2cc8d1a86f593a387f3cfc467d7d5a1cb8538fbdbeb6fbc0527b39304d"
    sha256                               arm64_sequoia: "f25a062830cdc07778ab227893fc77a49e88fcb1c48a83cccfce5f678468e668"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "91708bc79cd2280a54d1b2412887e648807d22f62b0b88efaa369a7dc0a5d5dd"
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
