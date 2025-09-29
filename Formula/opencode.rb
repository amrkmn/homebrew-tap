class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.13.5.tgz"
  sha256 "bf586a8dfd104a8c775a24bc4acfb67655528b015b49a9785ab252bf2154c48b"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "51fcb7c329b3601ea20f3981177b2831c966a287bc69ebefa1f9850e85bf7295"
    sha256                               arm64_sequoia: "c24c5d910c8fe936ed693d0b4c474b1248d4152667f49ecc14308fbe5361b1da"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "85d740fcc7505dcf94715d743cd62951f77eb191ab81f8a0f81aaaef1ef1697e"
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
