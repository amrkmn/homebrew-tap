class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.14.2.tgz"
  sha256 "4751a967e1152585bd96a9cc06268c1c9e3ffc035bd0cedaf005f012db92ee4e"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "eabfd59bd0a8a0cf66af5107a04e6969b12e2c131229cc16db612217833d2f75"
    sha256                               arm64_sequoia: "13833d82d49ec6cd444c5fb630dcab032df4362d9cd3401c19b2a2df2f280802"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d38544c77df3a37b917075c574bf178825478374706460110ac3748168dfb141"
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
