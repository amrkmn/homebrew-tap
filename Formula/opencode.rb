class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.11.6.tgz"
  sha256 "db7b05c1d9f27a9835bfec6ad20ae47df41e1b3934191f2e144429b515b09085"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "85f99f0318907a374ce30ae3c307f343ec461ab566eb67e9f7b49559634b716a"
    sha256                               arm64_sequoia: "072ed34ab28eb8d4179a7a96e3cbbaf88bc3e93a04579260f2ab9a241089d502"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4b90aaaeafeddf337a340c84c445c5336d17eaea56843cb20a727d85dd11e990"
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
