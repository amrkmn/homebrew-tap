class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.15.13.tgz"
  sha256 "da5565a104c0c00d38f4fb160d2da1a0043f86c7864d9ad5d2d44cddae01b818"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "a51e3af6486fa8961dba720237bfa51a5bb4b13778ad44d312e2d19db2dc5835"
    sha256                               arm64_sequoia: "980e184e87854ecd47f53697ceb2558b333f99ce3be69ac72d768cdf37b79208"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1ea9067a89a1eb19bde8827a67202496fbef8239b078cdc2b1478b2c5a88e3bc"
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
