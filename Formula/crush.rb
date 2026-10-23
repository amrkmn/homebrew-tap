class Crush < Formula
  desc "Glamourous AI coding agent for your favourite terminal"
  homepage "https://charm.sh/crush"
  url "https://registry.npmjs.org/@charmland/crush/-/crush-0.98.2.tgz"
  sha256 "4befab0a4116c0bf8025ce1ea95d2335c3bf9ba2469b4ee0406274b6eb525f77"
  license "FSL-1.1-MIT"

  bottle do
    root_url "https://ghcr.io/v2/amrkmn/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "408f2dba85019aa9cdeb5cc2615ed743f36407922c53f55ee57998e62d86825e"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "9830839a0e8c1f3c6138c33319a4e2e321d84c0788667a90c894781430f4638f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e7e5342f3b04804e35a0eaab7c04f42472e2cdf3c7ce50a48c734c6202c75666"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]

    generate_completions_from_executable(bin/"crush", "completion")
  end

  test do
    assert_match "crush version v#{version}", shell_output("#{bin}/crush --version")
  end
end
