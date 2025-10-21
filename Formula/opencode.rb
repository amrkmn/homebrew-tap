class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.15.12.tgz"
  sha256 "fa49ff0ff19a68678c0f8a9c08f9f6977fceaf9400e9c2cf78b634ded2bbd420"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "ee1c415bb314bb43896fb8bfbfe81ba8b38f016af4ccd17eb337ffa49cbc17c2"
    sha256                               arm64_sequoia: "864e8e0897ca763396face054436901a0d652f393ad8a7e5f1e141cc506a635d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0566e90ad746dfccdb9f71678bb869bec6a19ff8e39c914ee7898a658b28fb0b"
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
