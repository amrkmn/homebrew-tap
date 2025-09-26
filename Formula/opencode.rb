class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.11.4.tgz"
  sha256 "509f397a35bf61eaf64b8705b03842503dfc1e08224713f7d0e0017e9d23d479"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "434b2e366d09916f8d476e435b88e05078d174acbf5883d7d11936e827241b0e"
    sha256                               arm64_sequoia: "bd10a5f17a095068980869323e0d55fbcf8f83d679c5fb0e541751a4f25f6123"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c87eb4ef1d9e82ce8188a5a8ecb21b97ff1cda708c7e5749ebd84bdd1c648642"
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
