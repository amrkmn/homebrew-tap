class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.10.0.tgz"
  sha256 "e376e32f08aff1433e3522d5b94763f80a878d9df13bea901c906d4673380918"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "9cea9853f5799d0744130c5820f7a36865137ec0f45af22a0b2bfedffc73aa0a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b2850e26d6105103d6e0b2008526da7fbf821501f84882b71dd59a68f476d4d2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d4835ba3538d6402894b9b6b2a48ac32e265d64aaded64563d0165da39be8e20"
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
