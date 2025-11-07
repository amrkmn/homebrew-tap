class Opencode < Formula
  desc "AI coding agent, built for the terminal"
  homepage "https://opencode.ai/"
  url "https://registry.npmjs.org/opencode-ai/-/opencode-ai-1.0.39.tgz"
  sha256 "f2f73c986f2b33e1efdea7088d1d82ab47ab146739c96d358bfc0cebc48acd8e"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256                               arm64_tahoe:   "ad6f9aff9e49328c7dea5e5329f39e653718201395c1009933dc9799fc2f0580"
    sha256                               arm64_sequoia: "24c7c4a638241c0e937d3da5259bbbb48751bcb82ecf50cf0cd00de0a07b2699"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "45e203adbf38a15a9bb817c1a08695b658006cf9b1d2cc2a8801e19d3052bb04"
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
