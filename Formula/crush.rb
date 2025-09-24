class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.10.0.tgz"
  sha256 "e376e32f08aff1433e3522d5b94763f80a878d9df13bea901c906d4673380918"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "bb7bf32c90fdd409149123e07a91a3071668ef4a75216793ed42405d4e922db4"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0d3973f21d8dd55cbdbfc9587011f6a298a4bd58a66846b251ed213d8af3e513"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "725b265e49d1404d2d02a0a5e604fe4c0e18940fd9c4293c0bb42abb6c24e42e"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "crush version v#{version}", shell_output("#{bin}/crush --version")
  end
end
