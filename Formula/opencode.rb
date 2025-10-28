class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.15.20.tgz"
  sha256 "9c4581611105485327101a0f63725706507e512d544ee49564c28dbc2909fb38"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "907ff4e0b091e02aba9c705c2ea430e87e0c68550a264c241dce8da39d34f635"
    sha256                               arm64_sequoia: "bd3798c2d48392f5dc8eb517ce0c9d1d15246e28d0d7bfe3f7e9a44b2861c5e5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "35e9cc45d42b492af915e7e59437d843ae628b5132dcbd4c75cda58e98c36504"
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
