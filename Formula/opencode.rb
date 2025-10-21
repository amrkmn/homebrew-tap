class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.15.11.tgz"
  sha256 "def8b3019ff91dfc7dd9af346eed9ddf9443298777ff4bc902174f1f7d72e49f"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "b62394112adc6c1a87b694220a78ba38b9e91f128e76936b628aa3579bfa247b"
    sha256                               arm64_sequoia: "422225c89b22f4f812abab2c7e04a06d82e2bf44dd5b220fe727c4b5c02c7a22"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "379a1be5a71b7bfe3c1bba427d6ff439e0f6c85e0ded519f687550bcf7cc9c8d"
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
