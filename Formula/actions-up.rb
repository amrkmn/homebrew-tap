class ActionsUp < Formula
  desc "Interactive CLI tool to update GitHub Actions"
  homepage "https://github.com/azat-io/actions-up"
  url "https://registry.npmjs.org/actions-up/-/actions-up-1.4.0.tgz"
  sha256 "30a78ca62ad6a19203fe6361ce26c6d1b27376c494b7e84a37ac4712d860b19f"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "21061ccf6a07874651a6339583e5540e2a4cb1e9b26ea45c6f38e3a5f5d4bfbb"
  end

  depends_on :linux
  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/actions-up --version")
  end
end
