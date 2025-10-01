class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-0.13.7.tgz"
  sha256 "329edd3e3ecf592967a501d36e0e7bd74c57b2c17957ec5373ef7fed595e1b1e"
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
