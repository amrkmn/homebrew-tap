class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.33.tgz"
  sha256 "8fd6f9f7632cbb58db79ce7fa4fa467d85d38699b3e60bfbdad9ee96ad0fd76b"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "8385eaeea9bdd9d028f5acd4a82a58b3d51beb729b11b74777c47e9e874e4f7c"
    sha256                               arm64_sequoia: "de633b6e44d50a43050d93d0cdc558f21b6005d89cda8b76d390f6d2781f5872"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ef989ca976a873a0b01575d62c2632409f5672598232b5ca2621dd1b2b1f8301"
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
